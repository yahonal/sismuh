param(
    [Parameter(Mandatory=$true)][string]$DataPath,
    [Parameter(Mandatory=$true)][string]$TemplatePath,
    [Parameter(Mandatory=$true)][string]$OutputName
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$desktop = [Environment]::GetFolderPath("Desktop")
if ([string]::IsNullOrWhiteSpace($desktop)) {
    $desktop = Join-Path $env:USERPROFILE "Desktop"
}

$logPath = Join-Path $desktop "GTD_Publish_Log.txt"
$outputPath = Join-Path $desktop $OutputName

function Log([string]$Text) {
    ("{0:yyyy-MM-dd HH:mm:ss}  {1}" -f (Get-Date), $Text) |
        Add-Content -LiteralPath $logPath -Encoding UTF8
}

function Format-GtdDate([string]$Value) {
    if ([string]::IsNullOrWhiteSpace($Value)) { return "" }

    $cultures = @(
        [System.Globalization.CultureInfo]::InvariantCulture,
        [System.Globalization.CultureInfo]::GetCultureInfo("en-US"),
        [System.Globalization.CultureInfo]::GetCultureInfo("en-GB"),
        [System.Globalization.CultureInfo]::GetCultureInfo("tr-TR")
    )

    foreach ($culture in $cultures) {
        $dt = [datetime]::MinValue
        if ([datetime]::TryParse(
            $Value,
            $culture,
            [System.Globalization.DateTimeStyles]::AllowWhiteSpaces,
            [ref]$dt
        )) {
            return $dt.ToString("dd.MM.yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
        }
    }

    # If parsing fails, keep the original value rather than blanking it.
    Log ("DATE FORMAT WARNING: Could not parse [" + $Value + "]; original value will be used.")
    return $Value
}

function Count-Literal([string]$Text, [string]$Needle) {
    if ([string]::IsNullOrEmpty($Needle)) { return 0 }
    $count = 0
    $start = 0
    while ($true) {
        $idx = $Text.IndexOf($Needle, $start, [System.StringComparison]::Ordinal)
        if ($idx -lt 0) { break }
        $count++
        $start = $idx + $Needle.Length
    }
    return $count
}

function Xml-Escape([string]$Value) {
    if ($null -eq $Value) { return "" }

    # Remove XML 1.0 illegal control chars first.
    $clean = [regex]::Replace($Value, "[\x00-\x08\x0B\x0C\x0E-\x1F]", "")

    # Escape &, <, >, quotes and apostrophes for safe insertion into XML text.
    return [System.Security.SecurityElement]::Escape($clean)
}

function Replace-ScalarMarkersRaw([string]$PartPath, [hashtable]$Map) {
    if (-not (Test-Path -LiteralPath $PartPath)) { return }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $content = [System.IO.File]::ReadAllText($PartPath, [System.Text.Encoding]::UTF8)

    foreach ($key in $Map.Keys) {
        $content = $content.Replace($key, (Xml-Escape ([string]$Map[$key])))
    }

    [System.IO.File]::WriteAllText($PartPath, $content, $utf8NoBom)
}

function Build-OrderedTableXml($Cells) {
    $fragment = New-Object System.Text.StringBuilder
    $allCells = @($Cells)

    if ($allCells.Count -eq 0) {
        return ""
    }

    [void]$fragment.Append(
        '<w:tbl>' +
        '<w:tblPr>' +
        '<w:tblStyle w:val="TableGrid"/>' +
        '<w:tblW w:w="0" w:type="auto"/>' +
        '<w:tblLayout w:type="autofit"/>' +
        '</w:tblPr>'
    )

    $rowGroups = @($allCells | Group-Object row | Sort-Object { [int]$_.Name })

    foreach ($rg in $rowGroups) {
        [void]$fragment.Append('<w:tr>')

        $rowCells = @($rg.Group | Sort-Object { [int]$_.col })

        foreach ($cell in $rowCells) {
            $txt = Xml-Escape ([string]$cell.text)

            [void]$fragment.Append(
                '<w:tc>' +
                '<w:tcPr><w:tcW w:w="0" w:type="auto"/></w:tcPr>' +
                '<w:p><w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
                '<w:r><w:rPr>' +
                '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
                '<w:sz w:val="20"/><w:szCs w:val="20"/>' +
                '</w:rPr><w:t xml:space="preserve">' +
                $txt +
                '</w:t></w:r></w:p>' +
                '</w:tc>'
            )
        }

        [void]$fragment.Append('</w:tr>')
    }

    [void]$fragment.Append('</w:tbl>')
    return $fragment.ToString()
}


$script:GtdImagePartCounter = 0
$script:GtdDrawingId = 100000

function Ensure-PngContentType([string]$WordDir) {
    $root = Split-Path -Parent $WordDir
    $contentTypesPath = Join-Path $root '[Content_Types].xml'
    if (-not (Test-Path -LiteralPath $contentTypesPath)) {
        throw "[Content_Types].xml not found: $contentTypesPath"
    }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $raw = [System.IO.File]::ReadAllText($contentTypesPath, [System.Text.Encoding]::UTF8)
    if ($raw -notmatch '<Default\b[^>]*Extension="png"') {
        $entry = '<Default Extension="png" ContentType="image/png"/>'
        $idx = $raw.LastIndexOf('</Types>', [System.StringComparison]::Ordinal)
        if ($idx -lt 0) { throw 'Invalid [Content_Types].xml: </Types> not found.' }
        $raw = $raw.Substring(0, $idx) + $entry + $raw.Substring($idx)
        [System.IO.File]::WriteAllText($contentTypesPath, $raw, $utf8NoBom)
        Log 'Added PNG content type to [Content_Types].xml.'
    }
}

function Add-ImageRelationship([string]$WordDir, [string]$Target) {
    $relsDir = Join-Path $WordDir '_rels'
    $relsPath = Join-Path $relsDir 'document.xml.rels'
    if (-not (Test-Path -LiteralPath $relsPath)) {
        throw "document.xml.rels not found: $relsPath"
    }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $raw = [System.IO.File]::ReadAllText($relsPath, [System.Text.Encoding]::UTF8)

    do {
        $script:GtdImagePartCounter++
        $rid = 'rIdGtdImage' + $script:GtdImagePartCounter
    } while ($raw -match ('\bId="' + [regex]::Escape($rid) + '"'))

    $rel = '<Relationship Id="' + $rid + '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' + $Target + '"/>'
    $idx = $raw.LastIndexOf('</Relationships>', [System.StringComparison]::Ordinal)
    if ($idx -lt 0) { throw 'Invalid document.xml.rels: </Relationships> not found.' }
    $raw = $raw.Substring(0, $idx) + $rel + $raw.Substring($idx)
    [System.IO.File]::WriteAllText($relsPath, $raw, $utf8NoBom)
    return $rid
}

function Get-ImageExtentEmu([int]$Width10pt, [int]$Height10pt) {
    # DOORS getPictBB returns tenths of a point. 1/10 pt = 1270 EMU.
    if ($Width10pt -le 0 -or $Height10pt -le 0) {
        $cx = [int64](4.0 * 914400)
        $cy = [int64](3.0 * 914400)
    }
    else {
        $cx = [int64]$Width10pt * 1270
        $cy = [int64]$Height10pt * 1270
    }

    # Keep pictures inside a typical A4 content area while preserving aspect ratio.
    $maxCx = [int64](6.25 * 914400)
    $maxCy = [int64](8.25 * 914400)
    $scale = 1.0
    if ($cx -gt $maxCx) { $scale = [Math]::Min($scale, [double]$maxCx / [double]$cx) }
    if ($cy -gt $maxCy) { $scale = [Math]::Min($scale, [double]$maxCy / [double]$cy) }
    if ($scale -lt 1.0) {
        $cx = [int64][Math]::Round([double]$cx * $scale)
        $cy = [int64][Math]::Round([double]$cy * $scale)
    }

    return [pscustomobject]@{ cx = $cx; cy = $cy }
}

function Build-ImageParagraphXml(
    [string]$WordDir,
    [string]$SourcePath,
    [string]$ObjectId,
    [string]$PictureName,
    [int]$Width10pt,
    [int]$Height10pt
) {
    if (-not (Test-Path -LiteralPath $SourcePath)) {
        throw "Exported DOORS picture not found: $SourcePath"
    }

    Ensure-PngContentType $WordDir

    $mediaDir = Join-Path $WordDir 'media'
    if (-not (Test-Path -LiteralPath $mediaDir)) {
        New-Item -ItemType Directory -Path $mediaDir -Force | Out-Null
    }

    $safeId = ([string]$ObjectId -replace '[^A-Za-z0-9_.-]', '_')
    if ([string]::IsNullOrWhiteSpace($safeId)) { $safeId = 'picture' }

    $mediaName = ('gtd_{0}_{1}.png' -f $safeId, ([guid]::NewGuid().ToString('N').Substring(0,8)))
    $mediaPath = Join-Path $mediaDir $mediaName
    Copy-Item -LiteralPath $SourcePath -Destination $mediaPath -Force

    $target = 'media/' + $mediaName
    $rid = Add-ImageRelationship $WordDir $target

    $script:GtdDrawingId++
    $drawingId = $script:GtdDrawingId
    $extent = Get-ImageExtentEmu $Width10pt $Height10pt
    $cx = [string]$extent.cx
    $cy = [string]$extent.cy

    $displayName = [string]$PictureName
    if ([string]::IsNullOrWhiteSpace($displayName)) { $displayName = [string]$ObjectId }
    $displayName = Xml-Escape $displayName

    Log ("IMAGE PART object=" + $ObjectId + " source=" + $SourcePath + " target=" + $target + " rid=" + $rid + " cx=" + $cx + " cy=" + $cy)

    return (
        '<w:p>' +
        '<w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="center"/></w:pPr>' +
        '<w:r><w:drawing>' +
        '<wp:inline distT="0" distB="0" distL="0" distR="0">' +
        '<wp:extent cx="' + $cx + '" cy="' + $cy + '"/>' +
        '<wp:effectExtent l="0" t="0" r="0" b="0"/>' +
        '<wp:docPr id="' + $drawingId + '" name="' + $displayName + '"/>' +
        '<wp:cNvGraphicFramePr><a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/></wp:cNvGraphicFramePr>' +
        '<a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">' +
        '<a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
        '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
        '<pic:nvPicPr><pic:cNvPr id="0" name="' + $displayName + '"/><pic:cNvPicPr/></pic:nvPicPr>' +
        '<pic:blipFill><a:blip xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" r:embed="' + $rid + '"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill>' +
        '<pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' + $cx + '" cy="' + $cy + '"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr>' +
        '</pic:pic></a:graphicData></a:graphic>' +
        '</wp:inline>' +
        '</w:drawing></w:r>' +
        '</w:p>'
    )
}

function Replace-OrderedContentMarkerRaw(
    [string]$DocumentPath,
    [string]$Marker,
    $Events,
    [string]$WordDir
) {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $content = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)

    $markerEsc = [regex]::Escape($Marker)
    $pattern = '<w:p\b[^>]*>(?:(?!</w:p>).)*' + $markerEsc + '(?:(?!</w:p>).)*</w:p>'
    $match = [regex]::Match(
        $content,
        $pattern,
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # Word can split a marker across several runs. Accept known legacy names
    # and case differences, but only when the paragraph contains just a marker.
    if (-not $match.Success) {
        $paragraphMatches = [regex]::Matches(
            $content,
            '<w:p\b[^>]*>.*?</w:p>',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )
        foreach ($candidate in $paragraphMatches) {
            $textParts = [regex]::Matches(
                $candidate.Value,
                '<w:t\b[^>]*>(.*?)</w:t>',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            $paragraphText = (($textParts | ForEach-Object {
                [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
            }) -join '').Trim()
            $normalizedMarker = $paragraphText.ToUpperInvariant()
            if ($normalizedMarker -eq '{{SEC_DURUM_VE_MODLAR}}') {
                $normalizedMarker = '{{SEC_DURUM_MODLAR}}'
            }
            if ($normalizedMarker -ceq $Marker.ToUpperInvariant()) {
                $match = $candidate
                Log ("Ordered marker resolved: " + $paragraphText + " -> " + $Marker)
                break
            }
        }
    }

    if (-not $match.Success) {
        Log ("Ordered content marker not found: " + $Marker)
        return
    }

    $fragment = New-Object System.Text.StringBuilder
    $eventList = @($Events)
    $i = 0

    while ($i -lt $eventList.Count) {
        $ev = $eventList[$i]

        if ($ev.kind -eq "TEXT") {
            $txt = Xml-Escape ([string]$ev.text)

            [void]$fragment.Append(
                '<w:p>' +
                '<w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
                '<w:r><w:rPr>' +
                '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
                '<w:sz w:val="24"/><w:szCs w:val="24"/>' +
                '</w:rPr><w:t xml:space="preserve">' +
                $txt +
                '</w:t></w:r>' +
                '</w:p>'
            )

            $i++
            continue
        }

        if ($ev.kind -eq "REQ") {
            $id = Xml-Escape ([string]$ev.id)
            $txt = Xml-Escape ([string]$ev.text)

            [void]$fragment.Append(
                '<w:p>' +
                '<w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
                '<w:r><w:rPr>' +
                '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
                '<w:b/><w:sz w:val="24"/><w:szCs w:val="24"/>' +
                '</w:rPr><w:t xml:space="preserve">' +
                $id + ' ' +
                '</w:t></w:r>' +
                '<w:r><w:rPr>' +
                '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
                '<w:sz w:val="24"/><w:szCs w:val="24"/>' +
                '</w:rPr><w:t xml:space="preserve">' +
                $txt +
                '</w:t></w:r>' +
                '</w:p>'
            )

            $i++
            continue
        }

        if ($ev.kind -eq "IMAGE") {
            $imageXml = Build-ImageParagraphXml `
                $WordDir `
                ([string]$ev.path) `
                ([string]$ev.id) `
                ([string]$ev.name) `
                ([int]$ev.width10pt) `
                ([int]$ev.height10pt)

            [void]$fragment.Append($imageXml)
            $i++
            continue
        }

        if ($ev.kind -eq "TABLE_START") {
            $tableId = [string]$ev.tableId
            $cells = New-Object System.Collections.ArrayList
            $i++

            while ($i -lt $eventList.Count) {
                $inner = $eventList[$i]

                if ($inner.kind -eq "CELL" -and [string]$inner.tableId -eq $tableId) {
                    [void]$cells.Add($inner)
                    $i++
                    continue
                }

                if ($inner.kind -eq "TABLE_END" -and [string]$inner.tableId -eq $tableId) {
                    $i++
                    break
                }

                # Defensive break if the stream is malformed.
                break
            }

            [void]$fragment.Append((Build-OrderedTableXml $cells))
            continue
        }

        # CELL/TABLE_END should normally be consumed by TABLE_START.
        $i++
    }

    $newContent =
        $content.Substring(0, $match.Index) +
        $fragment.ToString() +
        $content.Substring($match.Index + $match.Length)

    [System.IO.File]::WriteAllText($DocumentPath, $newContent, $utf8NoBom)
}

function Build-TraceMatrixXml(
    [string]$TableXml,
    $Requirements,
    $TraceSources,
    $TraceFields,
    [string]$DefaultSystem
) {
    $rowMatches = [regex]::Matches($TableXml, '<w:tr\b[^>]*>.*?</w:tr>', 'Singleline')
    if ($rowMatches.Count -lt 2) { throw 'Trace matrix template must have a header and a prototype row.' }
    $headerXml = $rowMatches[0].Value

    # Center every header cell both horizontally and vertically.
    $headerXml = [regex]::Replace($headerXml, '<w:vAlign\b[^>]*/>', '')
    $headerXml = [regex]::Replace($headerXml, '</w:tcPr>', '<w:vAlign w:val="center"/></w:tcPr>')
    $headerXml = [regex]::Replace($headerXml, '<w:jc\b[^>]*/>', '<w:jc w:val="center"/>')
    $headerXml = [regex]::Replace(
        $headerXml,
        '<w:pPr\b[^>]*>.*?</w:pPr>',
        { param($m)
            $ppr = $m.Value
            if ($ppr -notmatch '<w:jc\b') {
                $ppr = [regex]::Replace($ppr, '</w:pPr>', '<w:jc w:val="center"/></w:pPr>')
            }
            return $ppr
        },
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    $prototypeCells = [regex]::Matches($rowMatches[1].Value, '<w:tc\b[^>]*>.*?</w:tc>', 'Singleline')
    if ($prototypeCells.Count -ne 5) { throw 'Trace matrix requires exactly five columns.' }
    $cellProperties = @()
    foreach ($cell in $prototypeCells) {
        $pr = [regex]::Match($cell.Value, '<w:tcPr\b[^>]*>.*?</w:tcPr>', 'Singleline').Value
        # Permit wrapping even where the original blank cells had noWrap.
        $pr = [regex]::Replace($pr, '<w:noWrap\b[^>]*/>', '')
        # Center cell content vertically.
        $pr = [regex]::Replace($pr, '<w:vAlign\b[^>]*/>', '')
        if ([string]::IsNullOrWhiteSpace($pr)) {
            $pr = '<w:tcPr><w:vAlign w:val="center"/></w:tcPr>'
        }
        else {
            $pr = [regex]::Replace($pr, '</w:tcPr>', '<w:vAlign w:val="center"/></w:tcPr>')
        }
        $cellProperties += $pr
    }
    $builder = New-Object System.Text.StringBuilder
    [void]$builder.Append($TableXml.Substring(0, $rowMatches[0].Index))
    [void]$builder.Append($headerXml)
    $rowCount = 0
    $unresolvedCount = 0
    $noSourceCount = 0
    foreach ($req in @($Requirements)) {
        $id = [string]$req.id
        if (-not $TraceSources.ContainsKey($id)) {
            throw ('No trace export record for ' + $id + '. Check GTD_Publish.dxl output.')
        }
        # The GTD traceability table uses a fixed value in the
        # "Ilgili Sistem/Altsistem" column for every data row.
        $relatedSystem = 'U/D'
        $note = ''
        $sourceType = ''
        $sourceReference = ''
        if ($TraceFields.ContainsKey($id)) {
            $note = [string]$TraceFields[$id].note
            $sourceType = [string]$TraceFields[$id].sourceType
            $sourceReference = [string]$TraceFields[$id].sourceReference
        }

        $sourceLabels = New-Object System.Collections.ArrayList

        switch ($sourceType) {
            'Higher-Level Requirement' {
                foreach ($source in @($TraceSources[$id])) {
                    $sourceLabel = ''
                    switch ([string]$source.status) {
                        'RESOLVED' {
                            if ([string]::IsNullOrWhiteSpace([string]$source.id)) {
                                $sourceLabel = 'Üst seviye kaynak okunamadı'
                                $unresolvedCount++
                            }
                            else {
                                $sourceLabel = [string]$source.id
                                if (-not [string]::IsNullOrWhiteSpace([string]$source.module)) {
                                    $sourceLabel += "`n" + [string]$source.module
                                }
                            }
                        }
                        'NONE' {
                            $sourceLabel = 'Üst seviye kaynak linki eksik'
                            $noSourceCount++
                        }
                        'UNREADABLE' {
                            $sourceLabel = 'Kaynak okunamadı'
                            if ($source.module) { $sourceLabel += "`n" + [string]$source.module }
                            $unresolvedCount++
                        }
                        'DELETED' {
                            $sourceLabel = 'Kaynak silinmiş'
                            if ($source.module) { $sourceLabel += "`n" + [string]$source.module }
                            $unresolvedCount++
                        }
                        default {
                            $sourceLabel = 'Kaynak durumu bilinmiyor'
                            $unresolvedCount++
                        }
                    }
                    [void]$sourceLabels.Add($sourceLabel)
                }
            }
            'Derived' {
                [void]$sourceLabels.Add('Türetilmiş Gereksinim')
            }
            'Standard / Regulation' {
                if ([string]::IsNullOrWhiteSpace($sourceReference)) {
                    [void]$sourceLabels.Add('Standart / Mevzuat kaynağı eksik')
                    $unresolvedCount++
                }
                else {
                    [void]$sourceLabels.Add('Standart / Mevzuat: ' + $sourceReference)
                }
            }
            'Interface' {
                if ([string]::IsNullOrWhiteSpace($sourceReference)) {
                    [void]$sourceLabels.Add('Arayüz kaynağı eksik')
                    $unresolvedCount++
                }
                else {
                    [void]$sourceLabels.Add('Arayüz: ' + $sourceReference)
                }
            }
            'Safety Analysis' {
                if ([string]::IsNullOrWhiteSpace($sourceReference)) {
                    [void]$sourceLabels.Add('Emniyet analizi kaynağı eksik')
                    $unresolvedCount++
                }
                else {
                    [void]$sourceLabels.Add('Emniyet Analizi: ' + $sourceReference)
                }
            }
            'Other' {
                if ([string]::IsNullOrWhiteSpace($sourceReference)) {
                    [void]$sourceLabels.Add('Diğer kaynak referansı eksik')
                    $unresolvedCount++
                }
                else {
                    [void]$sourceLabels.Add($sourceReference)
                }
            }
            default {
                # Do not silently classify an unset source as Derived.
                # If a valid upper link exists we can still show it, but the log
                # will contain SOURCE_TYPE_EMPTY/UNKNOWN_SOURCE_TYPE from DXL.
                $resolvedFallback = @($TraceSources[$id] | Where-Object { $_.status -eq 'RESOLVED' })
                if ($resolvedFallback.Count -gt 0) {
                    foreach ($source in $resolvedFallback) {
                        $sourceLabel = [string]$source.id
                        if (-not [string]::IsNullOrWhiteSpace([string]$source.module)) {
                            $sourceLabel += "`n" + [string]$source.module
                        }
                        [void]$sourceLabels.Add($sourceLabel)
                    }
                }
                else {
                    [void]$sourceLabels.Add('Kaynak Türü Tanımsız')
                    $noSourceCount++
                }
            }
        }

        foreach ($sourceLabel in @($sourceLabels)) {
            $values = @($id, $relatedSystem, [string]$req.verificationMethod, $note, [string]$sourceLabel)
            [void]$builder.Append('<w:tr><w:trPr><w:cantSplit/></w:trPr>')
            for ($col = 0; $col -lt 5; $col++) {
                [void]$builder.Append('<w:tc>' + $cellProperties[$col])
                [void]$builder.Append('<w:p><w:pPr><w:spacing w:before="0" w:after="60"/><w:jc w:val="center"/></w:pPr>')
                $lines = @(([string]$values[$col]) -split "\r?\n")
                for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
                    if ($lineIndex -gt 0) { [void]$builder.Append('<w:r><w:br/></w:r>') }
                    $escaped = Xml-Escape ([string]$lines[$lineIndex])
                    [void]$builder.Append('<w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="20"/><w:szCs w:val="20"/></w:rPr><w:t xml:space="preserve">' + $escaped + '</w:t></w:r>')
                }
                [void]$builder.Append('</w:p></w:tc>')
            }
            [void]$builder.Append('</w:tr>')
            $rowCount++
        }
    }
    if ($rowCount -eq 0) {
        [void]$builder.Append('<w:tr>')
        foreach ($pr in $cellProperties) { [void]$builder.Append('<w:tc>' + $pr + '<w:p><w:pPr><w:jc w:val="center"/></w:pPr></w:p></w:tc>') }
        [void]$builder.Append('</w:tr>')
    }
    [void]$builder.Append('</w:tbl>')
    Log ('TRACE_MATRIX rows=' + $rowCount + ' noSource=' + $noSourceCount + ' unresolved=' + $unresolvedCount)
    return $builder.ToString()
}

function Get-WordTablePlainText([string]$TableXml) {
    if ([string]::IsNullOrWhiteSpace($TableXml)) { return '' }

    $parts = [regex]::Matches(
        $TableXml,
        '<w:t\b[^>]*>(.*?)</w:t>',
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    return (($parts | ForEach-Object {
        [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
    }) -join ' ')
}

function Normalize-TraceSearchText([string]$Text) {
    if ([string]::IsNullOrWhiteSpace($Text)) { return '' }

    # Normalize Turkish/accented characters so trace-table discovery does not
    # depend on the exact Unicode representation saved by Word.
    $normalized = $Text.Normalize([System.Text.NormalizationForm]::FormD)
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $normalized.ToCharArray()) {
        $cat = [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch)
        if ($cat -ne [System.Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$sb.Append($ch)
        }
    }

    $asciiLike = $sb.ToString().Normalize([System.Text.NormalizationForm]::FormC).ToUpperInvariant()
    # Turkish dotless i does not decompose; normalize it explicitly.
    $asciiLike = $asciiLike.Replace([char]0x0131, 'I').Replace([char]0x0130, 'I')
    $asciiLike = [regex]::Replace($asciiLike, '\s+', ' ').Trim()
    return $asciiLike
}

function Replace-TraceMatrixRaw([string]$DocumentPath, $Requirements, $TraceSources, $TraceFields, [string]$DefaultSystem) {
    $raw = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
    $literalCount = Count-Literal $raw '{{TRACE_MATRIX}}'
    Log ('TRACE_MATRIX literalBefore=' + $literalCount)

    $matches = [regex]::Matches(
        $raw,
        '<w:tbl\b[^>]*>(?:(?!</w:tbl>).)*\{\{TRACE_MATRIX\}\}(?:(?!</w:tbl>).)*</w:tbl>',
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    $tableXml = ''
    $tableIndex = -1
    $tableLength = 0

    if ($matches.Count -eq 1) {
        $tableXml = $matches[0].Value
        $tableIndex = $matches[0].Index
        $tableLength = $matches[0].Length
        Log 'TRACE_MATRIX table resolved by direct regex.'
    }
    else {
        Log ('TRACE_MATRIX directTableMatches=' + $matches.Count + '; trying paragraph/table fallback.')

        # Fallback 1: marker may be split across Word runs.
        $paragraphMatches = [regex]::Matches(
            $raw,
            '<w:p\b[^>]*>.*?</w:p>',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )

        $markerParagraphIndex = -1
        foreach ($candidate in $paragraphMatches) {
            $textParts = [regex]::Matches(
                $candidate.Value,
                '<w:t\b[^>]*>(.*?)</w:t>',
                [System.Text.RegularExpressions.RegexOptions]::Singleline
            )
            $paragraphText = (($textParts | ForEach-Object {
                [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
            }) -join '').Trim()

            if ($paragraphText -ceq '{{TRACE_MATRIX}}') {
                $markerParagraphIndex = $candidate.Index
                break
            }
        }

        if ($markerParagraphIndex -ge 0) {
            $tableIndex = $raw.LastIndexOf('<w:tbl', $markerParagraphIndex, [System.StringComparison]::Ordinal)
            $tableEndStart = $raw.IndexOf('</w:tbl>', $markerParagraphIndex, [System.StringComparison]::Ordinal)
            if ($tableIndex -ge 0 -and $tableEndStart -ge 0) {
                $tableEnd = $tableEndStart + '</w:tbl>'.Length
                $tableLength = $tableEnd - $tableIndex
                $tableXml = $raw.Substring($tableIndex, $tableLength)
                Log 'TRACE_MATRIX table resolved by marker-paragraph fallback.'
            }
        }
    }

    # Fallback 2: do not depend on {{TRACE_MATRIX}} at all. Identify the
    # prototype trace table by its visible column headers. This survives Word
    # splitting/removing the hidden marker run.
    if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
        Log 'TRACE_MATRIX marker fallback failed; trying header-based table discovery.'

        $allTables = [regex]::Matches(
            $raw,
            '<w:tbl\b[^>]*>.*?</w:tbl>',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )

        $headerCandidates = New-Object System.Collections.ArrayList
        foreach ($candidate in $allTables) {
            $plainRaw = Get-WordTablePlainText $candidate.Value
            $plain = Normalize-TraceSearchText $plainRaw

            $hasReq = $plain.Contains('GEREKSINIM')
            $hasVerify = $plain.Contains('DOGRULAMA YONTEMI')
            $hasSource = $plain.Contains('KAYNAGI')
            $hasSystem = $plain.Contains('SISTEM')

            if ($hasReq -and $hasVerify -and $hasSource -and $hasSystem) {
                [void]$headerCandidates.Add($candidate)
            }
        }

        Log ('TRACE_MATRIX headerTableMatches=' + $headerCandidates.Count)

        if ($headerCandidates.Count -eq 1) {
            $resolved = $headerCandidates[0]
            $tableXml = $resolved.Value
            $tableIndex = $resolved.Index
            $tableLength = $resolved.Length
            Log 'TRACE_MATRIX table resolved by header-based fallback.'
        }
    }

    # Fallback 3: use the unique table that contains the two strongest trace
    # headers. This is intentionally narrower than simply selecting the last
    # table and remains safe if the template gains additional tables later.
    if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
        $strongCandidates = New-Object System.Collections.ArrayList
        foreach ($candidate in $allTables) {
            $plain = Normalize-TraceSearchText (Get-WordTablePlainText $candidate.Value)
            if ($plain.Contains('DOGRULAMA YONTEMI') -and $plain.Contains('GEREKSINIMIN KAYNAGI')) {
                [void]$strongCandidates.Add($candidate)
            }
        }
        Log ('TRACE_MATRIX strongHeaderMatches=' + $strongCandidates.Count)
        if ($strongCandidates.Count -eq 1) {
            $resolved = $strongCandidates[0]
            $tableXml = $resolved.Value
            $tableIndex = $resolved.Index
            $tableLength = $resolved.Length
            Log 'TRACE_MATRIX table resolved by strong-header fallback.'
        }
    }

    if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
        throw ('TRACE_MATRIX table could not be resolved. literalCount=' + $literalCount + '; directTableMatches=' + $matches.Count)
    }

    $replacement = Build-TraceMatrixXml $tableXml $Requirements $TraceSources $TraceFields $DefaultSystem
    $newRaw = $raw.Substring(0, $tableIndex) + $replacement + $raw.Substring($tableIndex + $tableLength)
    [System.IO.File]::WriteAllText($DocumentPath, $newRaw, (New-Object System.Text.UTF8Encoding($false)))

    $afterRaw = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
    Log ('TRACE_MATRIX literalAfter=' + (Count-Literal $afterRaw '{{TRACE_MATRIX}}'))
}

function Validate-XmlFiles([string]$Root) {
    $xmlFiles = @()
    $xmlFiles += Get-ChildItem -LiteralPath $Root -Recurse -Filter "*.xml" |
        Where-Object { -not $_.PSIsContainer }
    $xmlFiles += Get-ChildItem -LiteralPath $Root -Recurse -Filter "*.rels" |
        Where-Object { -not $_.PSIsContainer }

    foreach ($xf in $xmlFiles) {
        $reader = $null
        try {
            $settings = New-Object System.Xml.XmlReaderSettings
            $settings.CheckCharacters = $true
            $reader = [System.Xml.XmlReader]::Create($xf.FullName, $settings)
            while ($reader.Read()) { }
        }
        catch {
            Log ("INVALID XML PART: " + $xf.FullName)
            Log $_.Exception.Message
            throw ("Invalid XML generated in " + $xf.Name + ": " + $_.Exception.Message)
        }
        finally {
            if ($null -ne $reader) {
                $reader.Dispose()
                $reader = $null
            }
        }
    }
}

try {
    "" | Set-Content -LiteralPath $logPath -Encoding UTF8
    Log "GTD publish started."
    Log "DataPath: $DataPath"
    Log "TemplatePath: $TemplatePath"
    Log "OutputPath: $outputPath"

    if (-not (Test-Path -LiteralPath $DataPath)) {
        throw "Data file not found: $DataPath"
    }

    if (-not (Test-Path -LiteralPath $TemplatePath)) {
        throw "Template not found: $TemplatePath"
    }

    Log "===== TEMPLATE IDENTITY ====="
    $tplItem = Get-Item -LiteralPath $TemplatePath
    $tplHash = (Get-FileHash -LiteralPath $TemplatePath -Algorithm SHA256).Hash.ToLowerInvariant()
    Log ("Template FullName: " + $tplItem.FullName)
    Log ("Template Length: " + $tplItem.Length)
    Log ("Template LastWriteTime: " + $tplItem.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss"))
    Log ("Template SHA256: " + $tplHash)
    # --------------------------------------------------------
    # Read simple pipe-delimited DOORS data.
    # --------------------------------------------------------
    $meta = @{}
    $reqs = New-Object System.Collections.ArrayList
    $orderedContent = @{}
    $traceSources = @{}
    $traceFields = @{}

    $lines = Get-Content -LiteralPath $DataPath -Encoding Default

    foreach ($line in $lines) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }

        $parts = $line.Split('|')

        if ($parts[0] -eq "M" -and $parts.Count -ge 3) {
            $meta[$parts[1]] = $parts[2]
        }
        elseif ($parts[0] -eq "R" -and $parts.Count -ge 6) {
            [void]$reqs.Add([pscustomobject]@{
                id = $parts[1]
                type = $parts[2]
                text = $parts[3]
                verificationMethod = $parts[4]
                verificationReference = $parts[5]
            })
        }
        elseif ($parts[0] -eq "Q" -and $parts.Count -ge 4) {
            $sourceType = ''
            $sourceReference = ''
            if ($parts.Count -ge 5) { $sourceType = $parts[4] }
            if ($parts.Count -ge 6) { $sourceReference = $parts[5] }
            $traceFields[$parts[1]] = [pscustomobject]@{
                relatedSystem = $parts[2]
                note = $parts[3]
                sourceType = $sourceType
                sourceReference = $sourceReference
            }
        }
        elseif ($parts[0] -eq "X" -and $parts.Count -ge 6) {
            $traceId = $parts[1]
            if (-not $traceSources.ContainsKey($traceId)) {
                $traceSources[$traceId] = New-Object System.Collections.ArrayList
            }
            [void]$traceSources[$traceId].Add([pscustomobject]@{
                id = $parts[2]; module = $parts[3]; linkModule = $parts[4]; status = $parts[5]
            })
        }
        elseif ($parts[0] -eq "O" -and $parts.Count -ge 3) {
            $key = $parts[1]
            if (-not $orderedContent.ContainsKey($key)) {
                $orderedContent[$key] = New-Object System.Collections.ArrayList
            }

            $kind = $parts[2]

            if ($kind -eq "TEXT" -and $parts.Count -ge 4) {
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "TEXT"
                    text = $parts[3]
                })
            }
            elseif ($kind -eq "REQ" -and $parts.Count -ge 7) {
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "REQ"
                    id = $parts[3]
                    text = $parts[4]
                    verificationMethod = $parts[5]
                    verificationReference = $parts[6]
                })
            }
            elseif ($kind -eq "IMAGE" -and $parts.Count -ge 7) {
                $pictureName = ""
                if ($parts.Count -ge 8) { $pictureName = $parts[7] }
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "IMAGE"
                    id = $parts[3]
                    path = $parts[4]
                    width10pt = [int]$parts[5]
                    height10pt = [int]$parts[6]
                    name = $pictureName
                })
            }
            elseif ($kind -eq "TABLE_START" -and $parts.Count -ge 4) {
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "TABLE_START"
                    tableId = $parts[3]
                })
            }
            elseif ($kind -eq "CELL" -and $parts.Count -ge 7) {
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "CELL"
                    tableId = $parts[3]
                    row = [int]$parts[4]
                    col = [int]$parts[5]
                    text = $parts[6]
                })
            }
            elseif ($kind -eq "TABLE_END" -and $parts.Count -ge 4) {
                [void]$orderedContent[$key].Add([pscustomobject]@{
                    kind = "TABLE_END"
                    tableId = $parts[3]
                })
            }
        }
        elseif ($parts[0] -eq "D") {
            Log ("DXL " + (($parts | Select-Object -Skip 1) -join " | "))
        }
    }

    Log ("Metadata records: " + $meta.Count)
    Log ("Requirements: " + $reqs.Count)
    Log ("Ordered content sections: " + $orderedContent.Count)

    foreach ($group in ($reqs | Group-Object type | Sort-Object Name)) {
        Log ("Requirement type [" + $group.Name + "]: " + $group.Count)
    }

    foreach ($key in ($orderedContent.Keys | Sort-Object)) {
        $events = @($orderedContent[$key])
        $reqCount = @($events | Where-Object { $_.kind -eq "REQ" }).Count
        $imageCount = @($events | Where-Object { $_.kind -eq "IMAGE" }).Count
        $tableCount = @($events | Where-Object { $_.kind -eq "TABLE_START" }).Count
        $textCount = @($events | Where-Object { $_.kind -eq "TEXT" }).Count
        Log ("Content [" + $key + "]: total=" + $events.Count +
             " req=" + $reqCount + " image=" + $imageCount +
             " table=" + $tableCount + " text=" + $textCount)
    }

    if ($meta.Count -eq 0) {
        throw "DOORS data file was read but no metadata records were found."
    }

    Copy-Item -LiteralPath $TemplatePath -Destination $outputPath -Force

    $work = Join-Path $env:TEMP ("GTD_BUILD_" + [guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Path $work -Force | Out-Null
    Log "Work folder: $work"

    try {
        [System.IO.Compression.ZipFile]::ExtractToDirectory($outputPath,$work)

        $projDept = [string]$meta["ProjectName"]
        if ([string]$meta["Department"]) {
            if ($projDept) { $projDept += " / " }
            $projDept += [string]$meta["Department"]
        }

        $map = @{
            "{{SYS}}"       = [string]$meta["SystemName"]
            "{{DOCNO}}"     = [string]$meta["DocumentNumber"]
            "{{REV}}"       = [string]$meta["DocumentRevision"]
            "{{DATE}}"      = Format-GtdDate ([string]$meta["DocumentDate"])
            "{{PROJ_DEPT}}" = $projDept
            "{{PROJNO}}"    = [string]$meta["ProjectNumber"]
            "{{WORK}}"      = [string]$meta["WorkPackage"]
            "{{SDVIL}}"     = [string]$meta["SDVILNumber"]
            "{{CLASS}}"     = [string]$meta["Classification"]
        }

        $wordDir = Join-Path $work "word"

        # IMPORTANT:
        # Do NOT parse + re-save Word XML parts here.
        $xmlParts = @(
            Get-ChildItem -LiteralPath $wordDir -Filter "*.xml" |
            Where-Object { -not $_.PSIsContainer }
        )

        # Build the traceability matrix before any marker replacement so the
        # template placeholder is still untouched.
        $docXml = Join-Path $wordDir "document.xml"
        Log "===== TRACE MATRIX BEFORE ALL REPLACEMENTS ====="
        Replace-TraceMatrixRaw $docXml $reqs $traceSources $traceFields ([string]$meta["SystemName"])

        Log "Replacing scalar markers..."
        foreach ($part in $xmlParts) {
            Replace-ScalarMarkersRaw $part.FullName $map
        }

        foreach ($key in $map.Keys) {
            $left = 0
            foreach ($part in $xmlParts) {
                $raw = [System.IO.File]::ReadAllText($part.FullName, [System.Text.Encoding]::UTF8)
                $left += Count-Literal $raw $key
            }
            if ($left -gt 0) {
                Log ("WARNING: scalar marker remains " + $key + " count=" + $left)
            }
        }

        $orderedMarkers = @{
            # 1. GENEL
            "AMAC"              = "{{SEC_AMAC}}"
            "KAPSAM"            = "{{SEC_KAPSAM}}"
            "PROJE_TANITIMI"    = "{{SEC_PROJE_TANITIMI}}"
            "SISTEM_GENEL"      = "{{SEC_SISTEM_GENEL}}"
            "URUN_GENEL"        = "{{SEC_URUN_GENEL}}"
            "KISALTMALAR"       = "{{SEC_KISALTMALAR}}"
            "TANIMLAR"          = "{{SEC_TANIMLAR}}"
            "UYGULANABILIR_DOKUMANLAR" = "{{SEC_UYGULANABILIR_DOKUMANLAR}}"
            "STANDARTLAR"       = "{{SEC_STANDARTLAR}}"
            "DIGER_DOKUMANLAR"  = "{{SEC_DIGER_DOKUMANLAR}}"

            # 2. SİSTEMİN TANIMLAMASI
            "DURUM_MODLAR"      = "{{SEC_DURUM_MODLAR}}"
            "OMUR_DONGUSU"      = "{{SEC_OMUR_DONGUSU}}"
            "SINIRLAMALAR"      = "{{SEC_SINIRLAMALAR}}"

            # 3. GEREKSİNİMLER
            "REQ_ISLEVSEL"      = "{{REQ_ISLEVSEL}}"
            "REQ_PERFORMANS"    = "{{REQ_PERFORMANS}}"
            "REQ_FIZIKSEL"      = "{{REQ_FIZIKSEL}}"
            "REQ_ARAYUZ"        = "{{REQ_ARAYUZ}}"
            "REQ_CEVRESEL"      = "{{REQ_CEVRESEL}}"
            "REQ_EMNIYET"       = "{{REQ_EMNIYET}}"
            "REQ_ELD"           = "{{REQ_ELD}}"
            "REQ_GUV_GIZ"       = "{{REQ_GUV_GIZ}}"
            "REQ_ERGONOMI"      = "{{REQ_ERGONOMI}}"
            "REQ_MARKALAMA"     = "{{REQ_MARKALAMA}}"
            "REQ_BILGISAYAR"    = "{{REQ_BILGISAYAR}}"
        }

        Log "Writing ordered DOORS content..."

        foreach ($key in $orderedMarkers.Keys) {
            $events = @()
            if ($orderedContent.ContainsKey($key)) {
                $events = @($orderedContent[$key])
            }

            $marker = $orderedMarkers[$key]
            $rawBefore = [System.IO.File]::ReadAllText($docXml, [System.Text.Encoding]::UTF8)
            $markerCount = Count-Literal $rawBefore $marker
            if ($markerCount -eq 0) {
                Log ("WARNING: ordered marker not found " + $marker)
            }

            Replace-OrderedContentMarkerRaw $docXml $marker $events $wordDir

            if ($events.Count -gt 0) {
                Log ("WROTE [" + $key + "] events=" + $events.Count)
            }
        }


        Log "Validating all DOCX XML parts..."
        Validate-XmlFiles $work
        Log "XML validation passed."

        Remove-Item -LiteralPath $outputPath -Force

        [System.IO.Compression.ZipFile]::CreateFromDirectory(
            $work,
            $outputPath,
            [System.IO.Compression.CompressionLevel]::Optimal,
            $false
        )
    }
    finally {
        if (Test-Path -LiteralPath $work) {
            Remove-Item -LiteralPath $work -Recurse -Force
        }
    }

    if (-not (Test-Path -LiteralPath $outputPath)) {
        throw "Output DOCX was not created."
    }

    Log "SUCCESS"
    Log "Created: $outputPath"

    Start-Process explorer.exe -ArgumentList "/select,`"$outputPath`""
    exit 0
}
catch {
    Log "FAILED"
    Log $_.Exception.Message
    Log $_.ScriptStackTrace

    try {
        Start-Process notepad.exe -ArgumentList "`"$logPath`""
    } catch {}

    exit 1
}
