# Researcher için gerçek kod kesitleri

Bunlar güncel adaydan mekanik alınmış satır numaralı kesitlerdir. Tam işlev gövdesi her kesitte yer almayabilir. Kod değişmedi; arşivdeki gerçek dosyalar tamdır. `0001 |` önekleri kaynak dosyanın parçası değildir.

## GTD_Setup_Module.dxl — Module gtdSetupModule = current

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 9; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0009 | Module gtdSetupModule = current
0010 | if (null gtdSetupModule) {
0011 |     ack "Acik bir formal module bulunamadi."
0012 |     halt
0013 | }
0014 | if (baseline(gtdSetupModule) || !isEdit(gtdSetupModule)) {
0015 |     ack "Setup icin guncel modulu Exclusive Edit modunda acin."
0016 |     halt
0017 | }
0018 | 
0019 | // BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
0020 | string headingBytes(int first, int second, int third)
0021 | {
0022 |     Buffer b = create
0023 |     char c1 = charOf(first)
0024 |     b += c1
0025 |     if (second >= 0) {
0026 |         char c2 = charOf(second)
0027 |         b += c2
0028 |     }
0029 |     if (third >= 0) {
0030 |         char c3 = charOf(third)
````


## GTD_Setup_Module.dxl — string gtdStoredSectionKey(Object o)

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 335; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0335 | string gtdStoredSectionKey(Object o)
0336 | {
0337 |     if (null o) return ""
0338 |     Module om = module(o)
0339 |     AttrDef ad = find(om, "GTD Section Key")
0340 |     if (null ad || !ad.object) return ""
0341 |     return o."GTD Section Key" ""
0342 | }
0343 | 
0344 | string sectionKeyForObject(Object o)
0345 | {
0346 |     if (null o || isDeleted(o)) return ""
0347 |     if (table(o) || row(o) || cell(o)) return ""
0348 |     if (!gtdBlank(getPictName(o))) return ""
0349 |     string h = o."Object Heading" ""
0350 |     if (gtdBlank(h)) return ""
0351 |     string key = gtdStoredSectionKey(o)
0352 |     // A nonempty unknown key must not fall back to the visible title.
0353 |     if (!gtdBlank(key)) {
0354 |         if (gtdSectionIndex(key) >= 0) return key
0355 |         return ""
0356 |     }
0357 |     return sectionKeyForHeading(h)
0358 | }
0359 | 
0360 | string gtdSectionIdentityIssue(Object o)
0361 | {
0362 |     string stored = gtdStoredSectionKey(o)
0363 |     if (gtdBlank(stored)) return ""
0364 |     if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
0365 |     if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
0366 |     string h = o."Object Heading" ""
0367 |     if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
0368 |     string pict = getPictName(o)
0369 |     if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
0370 |     string titleKey = sectionKeyForHeading(h)
0371 |     if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
0372 |     return ""
0373 | }
0374 | 
0375 | // Start at the parent: a section heading is not its own requirement.
0376 | // A recognized container closes the search; do not inherit a stale section.
0377 | string sectionKeyFromParents(Object x)
0378 | {
0379 |     Object p = parent(x)
0380 |     while (!null p) {
0381 |         string key = sectionKeyForObject(p)
0382 |         if (key != "") {
0383 |             if (isContentSection(key)) return key
0384 |             return ""
0385 |         }
0386 |         p = parent(p)
0387 |     }
0388 |     return ""
0389 | }
0390 | // END GTD SECTION MODEL
0391 | 
0392 | 
````


## GTD_Setup_Module.dxl — void gtdCheckAttribute(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 503; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0503 | void gtdCheckAttribute(string name, bool moduleScope, string kind)
0504 | {
0505 |     AttrDef ad = find(gtdSetupModule, name)
0506 |     if (null ad) return
0507 |     bool valid = true
0508 |     if (moduleScope && !ad.module) valid = false
0509 |     if (!moduleScope && !ad.object) valid = false
0510 |     AttrType at = ad.type
0511 |     if (null at) valid = false
0512 |     else {
0513 |         if (kind == "Date" && at.type != attrDate) valid = false
0514 |         if (kind == "Text" && !gtdTextType(at)) valid = false
0515 |         if (kind == "Choice" && !gtdTextType(at) && at.type != attrEnumeration) valid = false
0516 |         if (kind == "Key") {
0517 |             if (at.type != attrString || ad.inherit || ad.dxl || ad.multi) valid = false
0518 |         }
0519 |     }
0520 |     if (!valid) {
0521 |         gtdSchemaErrors++
0522 |         gtdLog("SCHEMA_CONFLICT | " name " | existing definition preserved")
0523 |     }
0524 | }
0525 | 
0526 | bool gtdHasEnumLabel(AttrType at, string label, bool normalize)
0527 | {
0528 |     int i
0529 |     for (i = 0; i < at.size; i++) {
0530 |         string value = at.strings[i]
0531 |         if (normalize) {
0532 |             if (compactHeading(value) == compactHeading(label)) return true
0533 |         }
0534 |         else if (value == label) return true
0535 |     }
0536 |     return false
0537 | }
0538 | 
0539 | void gtdCheckEnumeration(string attrName, string typeName, string labels[], int count, bool normalize)
0540 | {
0541 |     AttrDef ad = find(gtdSetupModule, attrName)
0542 |     AttrType at = null
0543 |     if (!null ad) at = ad.type
0544 |     else at = find(gtdSetupModule, typeName)
0545 |     if (null at) return
0546 |     // Existing String/Text definitions remain editable and retain their values.
0547 |     if (!null ad && gtdTextType(at)) return
0548 |     if (at.type != attrEnumeration) {
0549 |         gtdSchemaErrors++
0550 |         gtdLog("TYPE_CONFLICT | " typeName)
0551 |         return
0552 |     }
0553 |     int i
0554 |     for (i = 0; i < count; i++) {
0555 |         if (!gtdHasEnumLabel(at, labels[i], normalize)) {
0556 |             gtdSchemaErrors++
0557 |             gtdLog("ENUM_VALUE_MISSING | " attrName " | " labels[i] " | enum preserved; extend/map explicitly")
0558 |         }
0559 |     }
0560 | }
0561 | 
0562 | void gtdEnsureAttribute(string name, bool moduleScope, string typeName)
0563 | {
0564 |     AttrDef ad = find(gtdSetupModule, name)
0565 |     if (!null ad) {
0566 |         gtdLog("KEEP_ATTRIBUTE | " name)
0567 |         return
0568 |     }
0569 |     noError()
0570 |     if (moduleScope) ad = create module type typeName attribute name
0571 |     else ad = create object type typeName (inherit false) attribute name
0572 |     string err = lastError()
0573 |     if (null ad || !gtdBlank(err)) gtdFail("ATTRIBUTE_CREATE_FAILED | " name " | " err)
0574 |     gtdCreatedAttrs++
0575 |     gtdLog("CREATE_ATTRIBUTE | " name)
0576 | }
0577 | 
0578 | void gtdEnsureEnumeration(string attrName, string typeName, string labels[], int count)
0579 | {
0580 |     AttrDef ad = find(gtdSetupModule, attrName)
0581 |     if (!null ad) {
0582 |         gtdLog("KEEP_ATTRIBUTE | " attrName)
0583 |         return
0584 |     }
0585 |     AttrType at = find(gtdSetupModule, typeName)
0586 |     if (null at) {
0587 |         int values[count]
0588 |         int i
0589 |         for (i = 0; i < count; i++) values[i] = i+1
0590 |         string err = ""
0591 |         noError()
0592 |         at = create(typeName, labels, values, err)
0593 |         string runtimeErr = lastError()
0594 |         if (null at || !gtdBlank(err) || !gtdBlank(runtimeErr))
0595 |             gtdFail("ENUM_CREATE_FAILED | " typeName " | " err " " runtimeErr)
0596 |         gtdLog("CREATE_TYPE | " typeName)
0597 |     }
0598 |     gtdEnsureAttribute(attrName, false, typeName)
0599 | }
0600 | 
0601 | void gtdSetModuleString(string name, string value, bool onlyIfBlank)
0602 | {
0603 |     string old = gtdReadModuleString(name)
0604 |     if (old == value || (onlyIfBlank && !gtdBlank(old))) return
0605 |     noError()
0606 |     gtdSetupModule.(name) = value
0607 |     string err = lastError()
0608 |     if (!gtdBlank(err)) gtdFail("MODULE_VALUE_FAILED | " name " | " err)
0609 |     gtdLog("SET_MODULE_ATTRIBUTE | " name)
0610 | }
0611 | 
0612 | gtdLog("GTD SETUP | " fullName(gtdSetupModule))
0613 | gtdLog("Existing object identities, links, enum definitions and requirement values are preserved.")
0614 | int gtdI
0615 | for (gtdI = 0; gtdI < 16; gtdI++) {
0616 |     string kind = "Text"
0617 |     if (gtdModuleStrings[gtdI] == "Classification") kind = "Choice"
0618 |     gtdCheckAttribute(gtdModuleStrings[gtdI], true, kind)
0619 | }
0620 | gtdCheckAttribute("Document Date", true, "Date")
0621 | for (gtdI = 0; gtdI < 4; gtdI++) gtdCheckAttribute(gtdObjectTexts[gtdI], false, "Text")
0622 | gtdCheckAttribute("Requirement Source Reference", false, "Text")
0623 | gtdCheckAttribute("Requirement Type", false, "Choice")
0624 | gtdCheckAttribute("Verification Method", false, "Choice")
0625 | gtdCheckAttribute("Requirement Source Type", false, "Choice")
0626 | gtdCheckAttribute("GTD Section Key", false, "Key")
0627 | gtdCheckEnumeration("Requirement Type", "GTD Requirement Type", gtdRequirementTypes, 11, true)
0628 | gtdCheckEnumeration("Requirement Source Type", "GTD Requirement Source Type", gtdSourceTypes, 6, false)
0629 | // Existing verification vocabularies are retained; only a missing attribute/type is initialized.
0630 | AttrDef gtdExistingMethod = find(gtdSetupModule, "Verification Method")
0631 | if (null gtdExistingMethod)
0632 |     gtdCheckEnumeration("Verification Method", "GTD Verification Method", gtdVerificationMethods, 5, true)
0633 | if (gtdSchemaErrors > 0) gtdFail("Schema conflicts found. No module changes were made.")
0634 | 
````


## GTD_Setup_Module.dxl — Object gtdCreateHeading(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 756; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0756 | Object gtdCreateHeading(int idx, Object requiredParent)
0757 | {
0758 |     Object nextKnown = null
0759 |     int j
0760 |     for (j = idx+1; j < GTD_SECTION_COUNT; j++) {
0761 |         if (gtdSectionParents[j] != gtdSectionParents[idx]) continue
0762 |         if (gtdCandidateCount[j] != 1 || gtdIdentityConflict[j]) continue
0763 |         Object candidate = gtdCandidates[j]
0764 |         if (parent(candidate) == requiredParent) {
0765 |             nextKnown = candidate
0766 |             break
0767 |         }
0768 |     }
0769 |     Object created = null
0770 |     noError()
0771 |     if (!null nextKnown) created = create before nextKnown
0772 |     else if (!null requiredParent) created = create last below requiredParent
0773 |     else {
0774 |         // create(Module) PREPENDS, so use it only when there is no live root.
0775 |         Object lastRoot = null
0776 |         Object rootObject
0777 |         for rootObject in entire gtdSetupModule do {
0778 |             if (isDeleted(rootObject)) continue
0779 |             if (null parent(rootObject)) lastRoot = rootObject
0780 |         }
0781 |         if (null lastRoot) created = create(gtdSetupModule)
0782 |         else created = create after lastRoot
0783 |     }
0784 |     string err = lastError()
0785 |     if (null created || !gtdBlank(err)) gtdFail("HEADING_CREATE_FAILED | " gtdSectionKeys[idx] " | " err)
0786 |     noError()
0787 |     created."Object Heading" = gtdSectionHeadings[idx]
0788 |     created."GTD Section Key" = gtdSectionKeys[idx]
0789 |     err = lastError()
0790 |     if (!gtdBlank(err)) gtdFail("HEADING_VALUE_FAILED | " gtdSectionKeys[idx] " | " err)
0791 |     gtdCreatedHeadings++
0792 |     gtdLog("CREATE_HEADING | " gtdSectionKeys[idx] " | " identifier(created))
0793 |     return created
0794 | }
0795 | 
0796 | for (gtdI = 0; gtdI < GTD_SECTION_COUNT; gtdI++) {
0797 |     string sectionKey = gtdSectionKeys[gtdI]
0798 |     int parentIdx = gtdSectionParents[gtdI]
0799 |     Object expectedParent = null
0800 |     if (parentIdx >= 0) expectedParent = gtdResolved[parentIdx]
0801 |     if (gtdIdentityConflict[gtdI] || gtdCandidateCount[gtdI] > 1) {
0802 |         gtdBlockedHeadings++
0803 |         gtdLog("BLOCK_HEADING | " sectionKey " | duplicate or conflicting identity; no new heading")
0804 |         continue
0805 |     }
0806 |     if (parentIdx >= 0 && null expectedParent) {
0807 |         gtdBlockedHeadings++
0808 |         gtdLog("BLOCK_HEADING | " sectionKey " | parent unresolved; no new heading")
0809 |         continue
0810 |     }
0811 |     if (gtdCandidateCount[gtdI] == 1) {
0812 |         Object existing = gtdCandidates[gtdI]
0813 |         if (parent(existing) != expectedParent) {
0814 |             gtdBlockedHeadings++
0815 |             string parentLabel = "MODULE_ROOT"
0816 |             if (!null expectedParent) parentLabel = identifier(expectedParent)
0817 |             gtdLog("WRONG_PARENT | " sectionKey " | " identifier(existing) " | expected parent " parentLabel " | move manually, then rerun")
0818 |             continue
0819 |         }
0820 |         if (gtdBlank(gtdStoredSectionKey(existing))) {
0821 |             noError()
0822 |             existing."GTD Section Key" = sectionKey
0823 |             string err = lastError()
0824 |             if (!gtdBlank(err)) gtdFail("HEADING_TAG_FAILED | " identifier(existing) " | " err)
0825 |         }
0826 |         gtdResolved[gtdI] = existing
0827 |         gtdReusedHeadings++
0828 |         gtdLog("REUSE_HEADING | " sectionKey " | " identifier(existing))
0829 |     }
0830 |     else gtdResolved[gtdI] = gtdCreateHeading(gtdI, expectedParent)
0831 | }
````


## GTD_Setup_Module.dxl — bool gtdViewExists(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 833; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0833 | bool gtdViewExists(string viewName)
0834 | {
0835 |     string candidate
0836 |     for candidate in views(gtdSetupModule) do
0837 |         if (candidate == viewName) return true
0838 |     return false
0839 | }
0840 | 
0841 | void gtdAppendColumn(string attrName, int colWidth)
0842 | {
0843 |     int n = 0
0844 |     Column c
0845 |     for c in gtdSetupModule do n++
0846 |     c = insert column n
0847 |     attribute(c, attrName)
0848 |     title(c, attrName)
0849 |     width(c, colWidth)
0850 | }
0851 | 
0852 | void gtdEnsureView(string viewName, bool review)
0853 | {
0854 |     bool viewAlreadyExists = gtdViewExists(viewName)
0855 |     View v = view(viewName)
0856 |     noError()
0857 |     if (viewAlreadyExists) {
0858 |         bool loaded = load(v)
0859 |         string loadErr = lastError()
0860 |         if (!loaded || !gtdBlank(loadErr)) gtdFail("VIEW_LOAD_FAILED | " viewName " | " loadErr)
0861 |         if (!review) {
0862 |             gtdLog("KEEP_VIEW | " viewName)
0863 |             return
0864 |         }
0865 |     }
0866 |     else {
0867 |         bool standardLoaded = load(view("Standard view"))
0868 |         string loadErr = lastError()
0869 |         if (!standardLoaded || !gtdBlank(loadErr)) gtdFail("Standard view could not be loaded.")
0870 |         // Only the unsaved display is rebuilt; no existing saved view is replaced.
0871 |         Column c
0872 |         int oldColumnCount = 0
0873 |         for c in gtdSetupModule do oldColumnCount++
0874 |         int ci
0875 |         for (ci = 0; ci < oldColumnCount; ci++) delete(column 0)
0876 |         c = insert column 0
0877 |         attribute(c, "Object Identifier")
0878 |         title(c, "ID")
0879 |         width(c, 100)
0880 |         c = insert column 1
0881 |         main(c)
0882 |         title(c, "Baslik / Metin")
0883 |         width(c, 450)
0884 |         gtdAppendColumn("Requirement Type", 140)
0885 |         gtdAppendColumn("Verification Method", 130)
0886 |         gtdAppendColumn("Verification Reference", 160)
0887 |         gtdAppendColumn("Requirement Source Type", 175)
0888 |         gtdAppendColumn("Requirement Source Reference", 210)
0889 |         if (!review) {
0890 |             gtdAppendColumn("Rationale", 200)
0891 |             gtdAppendColumn("Remarks", 180)
0892 |             gtdAppendColumn("Traceability Note", 200)
0893 |         }
0894 |     }
0895 |     bool changed = !viewAlreadyExists
0896 |     if (review) {
0897 |         Column controlColumn = null
0898 |         Column col
0899 |         int n = 0
0900 |         int controlCount = 0
0901 |         for col in gtdSetupModule do {
0902 |             if (title(col) == "Control") {
0903 |                 controlColumn = col
0904 |                 controlCount++
0905 |             }
0906 |             n++
0907 |         }
0908 |         if (controlCount > 1) {
0909 |             gtdReviewNeeded++
0910 |             gtdLog("VIEW_CONFLICT | Requirement Review has multiple Control columns; kept unchanged")
0911 |             return
0912 |         }
0913 |         bool controlWasMissing = null controlColumn
0914 |         if (controlWasMissing) {
0915 |             controlColumn = insert column n
0916 |             title(controlColumn, "Control")
0917 |             width(controlColumn, 300)
0918 |             changed = true
0919 |         }
0920 |         string oldCode = ""
0921 |         if (!controlWasMissing && gtdBlank(attrName(controlColumn)) && !main(controlColumn)) oldCode = dxl(controlColumn)
0922 |         else if (!controlWasMissing && viewAlreadyExists) {
0923 |             gtdReviewNeeded++
0924 |             gtdLog("VIEW_CONFLICT | Control title belongs to a non-DXL column; kept unchanged")
0925 |             return
0926 |         }
0927 |         if (oldCode != gtdControlCode) {
0928 |             dxl(controlColumn, gtdControlCode)
0929 |             changed = true
0930 |         }
0931 |     }
0932 |     if (changed) {
0933 |         noError()
0934 |         refresh(gtdSetupModule)
0935 |         string refreshErr = lastError()
0936 |         if (!gtdBlank(refreshErr)) gtdFail("VIEW_REFRESH_FAILED | " viewName " | " refreshErr)
0937 |         noError()
0938 |         if (viewAlreadyExists) save(v)
0939 |         else {
0940 |             // Default view access inheritance is retained; no module ACL is changed.
0941 |             ViewDef def = create(gtdSetupModule, true)
0942 |             useWindows(def, false)
0943 |             save(gtdSetupModule, v, def)
0944 |         }
0945 |         string err = lastError()
0946 |         if (!gtdBlank(err)) gtdFail("VIEW_SAVE_FAILED | " viewName " | " err)
0947 |         if (viewAlreadyExists) {
0948 |             gtdUpdatedViews++
0949 |             gtdLog("UPDATE_CONTROL_ONLY | " viewName)
0950 |         }
0951 |         else {
0952 |             gtdCreatedViews++
0953 |             gtdLog("CREATE_VIEW | " viewName)
0954 |         }
0955 |     }
0956 |     else gtdLog("KEEP_VIEW | " viewName)
0957 | }
0958 | 
0959 | gtdEnsureView("Requirement Entry", false)
0960 | gtdEnsureView("Requirement Review", true)
````


## GTD_Requirement_Review_Control.dxl — int sourceLinkCount(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Requirement_Review_Control.dxl`; ilk satır 441; SHA256 `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11`.

````text
0441 | int sourceLinkCount(Object o, string traceLinkModulePath)
0442 | {
0443 |     if (traceLinkModulePath == "") return 0
0444 | 
0445 |     int count = 0
0446 |     Link traceLink
0447 | 
0448 |     for traceLink in all(o->"*") do {
0449 |         Module traceLinkModule = module(traceLink)
0450 |         if (!null traceLinkModule) {
0451 |             string actualLinkPath = fullName(traceLinkModule)
0452 |             if (actualLinkPath == traceLinkModulePath)
0453 |                 count++
0454 |         }
0455 |     }
0456 | 
0457 |     return count
0458 | }
0459 | 
0460 | // ------------------------------------------------------------
0461 | // Layout DXL execution for the current row/object.
````


## GTD_Requirement_Review_Control.dxl — // ---------------- Source validation

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Requirement_Review_Control.dxl`; ilk satır 526; SHA256 `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11`.

````text
0526 |             // ---------------- Source validation ----------------
0527 |             Module m = module(o)
0528 | 
0529 |             if (null m) {
0530 |                 addIssue(issues, "HATA: Module bulunamadi")
0531 |             }
0532 |             else {
0533 |                 AttrDef adSourceType = find(m, "Requirement Source Type")
0534 |                 AttrDef adSourceReference = find(m, "Requirement Source Reference")
0535 |                 AttrDef adTraceLinkModule = find(m, "GTD Trace Link Module")
0536 | 
0537 |                 if (null adSourceType || null adSourceReference) {
0538 |                     addIssue(issues, "HATA: Kaynak attribute tanimsiz")
0539 |                 }
0540 |                 else {
0541 |                     string sourceType = o."Requirement Source Type" ""
0542 |                     string sourceReference = o."Requirement Source Reference" ""
0543 |                     string traceLinkModulePath = ""
0544 | 
0545 |                     if (!null adTraceLinkModule)
0546 |                         traceLinkModulePath = m."GTD Trace Link Module" ""
0547 | 
0548 |                     int matchedSourceLinks = sourceLinkCount(o, traceLinkModulePath)
0549 | 
0550 |                     if (isBlank(sourceType)) {
0551 |                         addIssue(issues, "EKSIK: Requirement Source Type")
0552 |                     }
0553 |                     else if (sourceType == "Higher-Level Requirement") {
0554 |                         if (isBlank(traceLinkModulePath))
0555 |                             addIssue(issues, "HATA: GTD Trace Link Module tanimsiz")
0556 |                         else if (matchedSourceLinks == 0)
0557 |                             addIssue(issues, "HATA: Ust seviye kaynak linki yok")
0558 |                     }
0559 |                     else if (sourceType == "Derived") {
0560 |                         if (!isBlank(traceLinkModulePath) && matchedSourceLinks > 0)
0561 |                             addIssue(issues, "HATA: Derived ama kaynak linki var")
0562 |                     }
0563 |                     else if (sourceType == "Standard / Regulation" ||
0564 |                              sourceType == "Interface" ||
0565 |                              sourceType == "Safety Analysis" ||
0566 |                              sourceType == "Other") {
0567 |                         if (isBlank(sourceReference))
0568 |                             addIssue(issues, "EKSIK: Requirement Source Reference")
0569 |                     }
0570 |                     else {
0571 |                         addIssue(issues, "HATA: Bilinmeyen Requirement Source Type")
0572 |                     }
0573 |                 }
0574 |             }
0575 | 
0576 |             string result = stringOf(issues)
0577 |             if (result == "")
0578 |                 display "OK"
0579 |             else
0580 |                 display result
0581 | 
0582 |             delete(issues)
0583 |         }
0584 |     }
0585 | }
````


## GTD_Publish.dxl — string safeField(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 50; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0050 | string safeField(string s)
0051 | {
0052 |     Buffer b = create
0053 |     int i
0054 |     int n = length(s)
0055 | 
0056 |     for (i = 0; i < n; i++) {
0057 |         string ch = s[i:i]
0058 | 
0059 |         if (ch == "|" || ch == "\n" || ch == "\r" || ch == "\t")
0060 |             b += " "
0061 |         else
0062 |             b += ch
0063 |     }
0064 | 
0065 |     string r = stringOf(b)
0066 |     delete(b)
0067 |     return r
0068 | }
0069 | 
0070 | // Required: full path of the link module used for derived-from traceability.
0071 | // Link direction is current requirement -> upper/source requirement.
0072 | AttrDef adTraceLinkModule = find(m, "GTD Trace Link Module")
0073 | string traceLinkModulePath = ""
0074 | if (!null adTraceLinkModule) traceLinkModulePath = m."GTD Trace Link Module" ""
0075 | if (traceLinkModulePath == "" || traceLinkModulePath == "*") {
0076 |     ack "GTD Trace Link Module: set this module String attribute to the full path of your upper-requirement link module."
0077 |     halt
0078 | }
0079 | if (traceLinkModulePath[0:0] != "/") {
0080 |     ack "GTD Trace Link Module must be a full DOORS path beginning with /."
0081 |     halt
0082 | }
0083 | AttrDef adTraceNote = find(m, "Traceability Note")
````


## GTD_Publish.dxl — AttrDef gtdKeyAttr = find(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 554; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0554 | AttrDef gtdKeyAttr = find(m, "GTD Section Key")
0555 | bool gtdManagedStructure = !null gtdKeyAttr
0556 | if (gtdManagedStructure) {
0557 |     Buffer structureIssues = create
0558 |     if (gtdBlank(systemName) || gtdBlank(documentNumber) || gtdBlank(documentRevision) ||
0559 |         gtdBlank(documentDate) || gtdBlank(projectName) || gtdBlank(projectNumber) ||
0560 |         gtdBlank(department) || gtdBlank(classification) || gtdBlank(m."Prefix" ""))
0561 |         structureIssues += "Required document metadata is missing; run GTD_Module_Info.dxl.\n"
0562 |     AttrDef setupStateAttr = find(m, "GTD Setup State")
0563 |     if (null setupStateAttr || !setupStateAttr.module)
0564 |         structureIssues += "GTD Setup State missing; run GTD_Setup_Module.dxl.\n"
0565 |     else {
0566 |         string setupState = m."GTD Setup State" ""
0567 |         if (setupState != "READY")
0568 |             structureIssues += "Setup is incomplete; resolve the setup log and run it again.\n"
0569 |     }
0570 |     int sectionCount[GTD_SECTION_COUNT]
0571 |     int si
0572 |     for (si = 0; si < GTD_SECTION_COUNT; si++) sectionCount[si] = 0
0573 |     Object checkObject
0574 |     for checkObject in entire m do {
0575 |         if (isDeleted(checkObject)) continue
0576 |         string issue = gtdSectionIdentityIssue(checkObject)
0577 |         if (issue != "") structureIssues += identifier(checkObject) " : " issue "\n"
0578 |         if (table(checkObject) || row(checkObject) || cell(checkObject)) continue
0579 |         string key = sectionKeyForObject(checkObject)
0580 |         int idx = gtdSectionIndex(key)
0581 |         if (idx >= 0) {
0582 |             sectionCount[idx]++
0583 |             Object p = parent(checkObject)
0584 |             int pi = gtdSectionParents[idx]
0585 |             string expectedParent = ""
0586 |             if (pi >= 0) expectedParent = gtdSectionKeys[pi]
0587 |             string actualParent = sectionKeyForObject(p)
0588 |             bool wrongParent = false
0589 |             if (pi < 0 && !null p) wrongParent = true
0590 |             if (pi >= 0 && (null p || actualParent != expectedParent)) wrongParent = true
0591 |             if (wrongParent) structureIssues += identifier(checkObject) " : WRONG_PARENT " key "\n"
0592 |         }
0593 |         string rt = checkObject."Requirement Type" ""
0594 |         string txt = checkObject."Object Text" ""
0595 |         string head = checkObject."Object Heading" ""
0596 |         if (!gtdBlank(rt) && !gtdBlank(txt) && gtdBlank(head) && gtdBlank(getPictName(checkObject))) {
0597 |             string containing = sectionKeyFromParents(checkObject)
0598 |             if (!isRequirementSection(containing))
0599 |                 structureIssues += identifier(checkObject) " : REQUIREMENT_OUTSIDE_SECTION\n"
0600 |         }
0601 |     }
0602 |     for (si = 0; si < GTD_SECTION_COUNT; si++)
0603 |         if (sectionCount[si] != 1)
0604 |             structureIssues += gtdSectionKeys[si] " : expected one heading; found " sectionCount[si] "\n"
0605 |     if (length(stringOf(structureIssues)) > 0) {
0606 |         string structureLog = tempFileName() "_GTD_Structure_Check.txt"
0607 |         Stream structureOut = write(structureLog)
0608 |         if (!null structureOut) {
0609 |             structureOut << stringOf(structureIssues)
0610 |             close(structureOut)
0611 |         }
0612 |         print stringOf(structureIssues)
0613 |         close(out)
0614 |         ack "GTD bolum yapisi tamamlanmamis. Yayin durduruldu.\nSetup'i tekrar calistirin.\n\nKontrol raporu:\n" structureLog
0615 |         delete(structureIssues)
0616 |         halt
0617 |     }
0618 |     delete(structureIssues)
0619 | }
0620 | 
````


## GTD_Publish.dxl — // Q = supplemental matrix fields.

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 906; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0906 |         // Q = supplemental matrix fields. X = one outgoing source link per row.
0907 |         // Q|ReqId|RelatedSystem|TraceNote|SourceType|SourceReference
0908 |         string traceNote = ""
0909 |         if (!null adTraceNote) traceNote = o."Traceability Note" ""
0910 |         string sourceType = o."Requirement Source Type" ""
0911 |         string sourceReference = o."Requirement Source Reference" ""
0912 |         string sfTraceNote = safeField(traceNote)
0913 |         string sfSourceType = safeField(sourceType)
0914 |         string sfSourceReference = safeField(sourceReference)
0915 |         out << "Q|" << sfReqId << "|" << sfSystemName << "|" << sfTraceNote << "|" << sfSourceType << "|" << sfSourceReference << "\n"
0916 | 
0917 |         int matchedTraceLinks = 0
0918 |         Link traceLink
0919 |         for traceLink in all(o->"*") do {
0920 |             Module traceLinkModule = module(traceLink)
0921 |             string actualLinkPath = fullName(traceLinkModule)
0922 |             string sfActualLinkPath = safeField(actualLinkPath)
0923 |             if (actualLinkPath == traceLinkModulePath) {
0924 |                 matchedTraceLinks++
0925 |                 string traceSourceId = ""
0926 |                 string traceSourceModule = ""
0927 |                 string traceStatus = "UNREADABLE"
0928 |                 ModuleVersion traceTargetVersion = targetVersion(traceLink)
0929 |                 if (!null traceTargetVersion) {
0930 |                     ModName_ sourceModuleName = module(traceTargetVersion)
0931 |                     if (!null sourceModuleName) {
0932 |                         traceSourceModule = fullName(sourceModuleName)
0933 |                         if (!isDeleted(sourceModuleName)) {
0934 |                             Object sourceObject = target(traceLink)
0935 |                             if (null sourceObject) {
0936 |                                 noError()
0937 |                                 load(traceTargetVersion, false)
0938 |                                 string loadError = lastError()
0939 |                                 if (!null loadError && loadError != "") {
0940 |                                     string sfLoadError = safeField(loadError)
0941 |                                     out << "D|TRACE_LOAD_ERROR|" << sfReqId << "|" << sfLoadError << "\n"
0942 |                                 }
0943 |                                 sourceObject = target(traceLink)
0944 |                             }
0945 |                             if (!null sourceObject) {
0946 |                                 if (!isDeleted(sourceObject)) {
0947 |                                     traceSourceId = identifier(sourceObject)
0948 |                                     traceStatus = "RESOLVED"
0949 |                                 }
0950 |                                 else traceStatus = "DELETED"
0951 |                             }
0952 |                         }
0953 |                         else traceStatus = "DELETED"
0954 |                     }
0955 |                 }
0956 |                 string sfTraceSourceId = safeField(traceSourceId)
0957 |                 string sfTraceSourceModule = safeField(traceSourceModule)
0958 |                 out << "X|" << sfReqId << "|" << sfTraceSourceId << "|" << sfTraceSourceModule << "|" << sfActualLinkPath << "|" << traceStatus << "\n"
0959 |             }
0960 |         }
0961 |         if (matchedTraceLinks == 0) {
0962 |             out << "X|" << sfReqId << "||||NONE\n"
0963 |         }
0964 | 
0965 |         // Source-definition validation. Warnings do not block publishing yet.
0966 |         if (sourceType == "") {
0967 |             sourceValidationWarnings++
0968 |             out << "D|SOURCE_WARNING|" << sfReqId << "|SOURCE_TYPE_EMPTY\n"
0969 |         }
0970 |         else if (sourceType == "Higher-Level Requirement") {
0971 |             if (matchedTraceLinks == 0) {
0972 |                 sourceValidationWarnings++
0973 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|HIGHER_LEVEL_WITHOUT_LINK\n"
0974 |             }
0975 |         }
0976 |         else if (sourceType == "Derived") {
0977 |             if (matchedTraceLinks > 0) {
0978 |                 sourceValidationWarnings++
0979 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|DERIVED_HAS_UPPER_SOURCE_LINK\n"
0980 |             }
0981 |         }
0982 |         else if (sourceType == "Standard / Regulation" ||
0983 |                  sourceType == "Interface" ||
0984 |                  sourceType == "Safety Analysis" ||
0985 |                  sourceType == "Other") {
0986 |             if (sourceReference == "") {
0987 |                 sourceValidationWarnings++
0988 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|SOURCE_REFERENCE_EMPTY|" << sfSourceType << "\n"
0989 |             }
0990 |         }
0991 |         else {
0992 |             sourceValidationWarnings++
0993 |             out << "D|SOURCE_WARNING|" << sfReqId << "|UNKNOWN_SOURCE_TYPE|" << sfSourceType << "\n"
0994 |         }
0995 | 
0996 |     }
0997 |     }
0998 | }
0999 | 
1000 | string sourceWarningCountText = sourceValidationWarnings ""
1001 | out << "D|SOURCE_VALIDATION_SUMMARY|WARNINGS|" << sourceWarningCountText << "\n"
1002 | 
1003 | close(out)
1004 | 
1005 | // ------------------------------------------------------------
````


## GTD_Publish.dxl — // Copy network files to local TEMP, then run locally.

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 1006; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
1006 | // Copy network files to local TEMP, then run locally.
1007 | // ------------------------------------------------------------
1008 | string batPath = tmpBase ".bat"
1009 | string localScript = tmpBase "_GTD_Build_Document.ps1"
1010 | string localTemplate = tmpBase "_TPL_GTD_Publisher.docx"
1011 | 
1012 | Stream bat = write(batPath)
1013 | 
1014 | if (null bat) {
1015 |     ack "Gecici BAT dosyasi olusturulamadi."
1016 |     halt
1017 | }
1018 | 
1019 | bat << "@echo off\r\n"
1020 | bat << "setlocal\r\n"
1021 | bat << "cd /d \"%TEMP%\"\r\n"
1022 | 
1023 | bat << "copy /Y \"" scriptPath "\" \"" localScript "\" >nul\r\n"
1024 | bat << "if errorlevel 1 (\r\n"
1025 | bat << "  echo PowerShell dosyasi TEMP'e kopyalanamadi.\r\n"
1026 | bat << "  pause\r\n"
1027 | bat << "  exit /b 1\r\n"
1028 | bat << ")\r\n"
1029 | 
1030 | bat << "copy /Y \"" templatePath "\" \"" localTemplate "\" >nul\r\n"
1031 | bat << "if errorlevel 1 (\r\n"
1032 | bat << "  echo Word template TEMP'e kopyalanamadi.\r\n"
1033 | bat << "  pause\r\n"
1034 | bat << "  exit /b 1\r\n"
1035 | bat << ")\r\n"
1036 | 
1037 | bat << "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"" localScript "\" -DataPath \"" dataPath "\" -TemplatePath \"" localTemplate "\" -OutputName \"" outputName "\"\r\n"
1038 | bat << "set ERR=%ERRORLEVEL%\r\n"
1039 | bat << "del /Q \"" localScript "\" >nul 2>nul\r\n"
1040 | bat << "del /Q \"" localTemplate "\" >nul 2>nul\r\n"
1041 | bat << "exit /b %ERR%\r\n"
1042 | 
1043 | close(bat)
1044 | 
1045 | system("cmd.exe /c \"" batPath "\"")
1046 | 
1047 | infoBox "GTD yayin komutu tamamlandi.\n\nBasariliysa cikti Masaustunde secili gosterilecek.\nBasarisizsa Masaustundeki GTD_Publish_Log.txt otomatik acilacak."
````


## GTD_Build_Document.ps1 — function Replace-ScalarMarkersRaw(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 74; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0074 | function Replace-ScalarMarkersRaw([string]$PartPath, [hashtable]$Map) {
0075 |     if (-not (Test-Path -LiteralPath $PartPath)) { return }
0076 | 
0077 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0078 |     $content = [System.IO.File]::ReadAllText($PartPath, [System.Text.Encoding]::UTF8)
0079 | 
0080 |     foreach ($key in $Map.Keys) {
0081 |         $content = $content.Replace($key, (Xml-Escape ([string]$Map[$key])))
0082 |     }
0083 | 
0084 |     [System.IO.File]::WriteAllText($PartPath, $content, $utf8NoBom)
0085 | }
0086 | 
0087 | function Build-OrderedTableXml($Cells) {
0088 |     $fragment = New-Object System.Text.StringBuilder
````


## GTD_Build_Document.ps1 — function Replace-OrderedContentMarkerRaw(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 269; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0269 | function Replace-OrderedContentMarkerRaw(
0270 |     [string]$DocumentPath,
0271 |     [string]$Marker,
0272 |     $Events,
0273 |     [string]$WordDir
0274 | ) {
0275 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0276 |     $content = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
0277 | 
0278 |     $markerEsc = [regex]::Escape($Marker)
0279 |     $pattern = '<w:p\b[^>]*>(?:(?!</w:p>).)*' + $markerEsc + '(?:(?!</w:p>).)*</w:p>'
0280 |     $match = [regex]::Match(
0281 |         $content,
0282 |         $pattern,
0283 |         [System.Text.RegularExpressions.RegexOptions]::Singleline
0284 |     )
0285 | 
0286 |     # Word can split a marker across several runs. Accept known legacy names
0287 |     # and case differences, but only when the paragraph contains just a marker.
0288 |     if (-not $match.Success) {
0289 |         $paragraphMatches = [regex]::Matches(
0290 |             $content,
0291 |             '<w:p\b[^>]*>.*?</w:p>',
0292 |             [System.Text.RegularExpressions.RegexOptions]::Singleline
0293 |         )
0294 |         foreach ($candidate in $paragraphMatches) {
0295 |             $textParts = [regex]::Matches(
0296 |                 $candidate.Value,
0297 |                 '<w:t\b[^>]*>(.*?)</w:t>',
0298 |                 [System.Text.RegularExpressions.RegexOptions]::Singleline
0299 |             )
0300 |             $paragraphText = (($textParts | ForEach-Object {
0301 |                 [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
0302 |             }) -join '').Trim()
0303 |             $normalizedMarker = $paragraphText.ToUpperInvariant()
0304 |             if ($normalizedMarker -eq '{{SEC_DURUM_VE_MODLAR}}') {
0305 |                 $normalizedMarker = '{{SEC_DURUM_MODLAR}}'
0306 |             }
0307 |             if ($normalizedMarker -ceq $Marker.ToUpperInvariant()) {
0308 |                 $match = $candidate
0309 |                 Log ("Ordered marker resolved: " + $paragraphText + " -> " + $Marker)
0310 |                 break
0311 |             }
0312 |         }
0313 |     }
0314 | 
0315 |     if (-not $match.Success) {
0316 |         Log ("Ordered content marker not found: " + $Marker)
0317 |         return
0318 |     }
0319 | 
0320 |     $fragment = New-Object System.Text.StringBuilder
0321 |     $eventList = @($Events)
0322 |     $i = 0
0323 | 
0324 |     while ($i -lt $eventList.Count) {
0325 |         $ev = $eventList[$i]
0326 | 
0327 |         if ($ev.kind -eq "TEXT") {
0328 |             $txt = Xml-Escape ([string]$ev.text)
````


## GTD_Build_Document.ps1 — $lines = Get-Content -LiteralPath $DataPath -Encoding Default

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 848; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0848 |     $lines = Get-Content -LiteralPath $DataPath -Encoding Default
0849 | 
0850 |     foreach ($line in $lines) {
0851 |         if ([string]::IsNullOrWhiteSpace($line)) { continue }
0852 | 
0853 |         $parts = $line.Split('|')
0854 | 
0855 |         if ($parts[0] -eq "M" -and $parts.Count -ge 3) {
0856 |             $meta[$parts[1]] = $parts[2]
0857 |         }
0858 |         elseif ($parts[0] -eq "R" -and $parts.Count -ge 6) {
0859 |             [void]$reqs.Add([pscustomobject]@{
0860 |                 id = $parts[1]
0861 |                 type = $parts[2]
0862 |                 text = $parts[3]
0863 |                 verificationMethod = $parts[4]
````


## GTD_Build_Document.ps1 — Log "Validating all DOCX XML parts..."

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 1086; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
1086 |         Log "Validating all DOCX XML parts..."
1087 |         Validate-XmlFiles $work
1088 |         Log "XML validation passed."
1089 | 
1090 |         Remove-Item -LiteralPath $outputPath -Force
1091 | 
1092 |         [System.IO.Compression.ZipFile]::CreateFromDirectory(
1093 |             $work,
1094 |             $outputPath,
1095 |             [System.IO.Compression.CompressionLevel]::Optimal,
1096 |             $false
1097 |         )
1098 |     }
1099 |     finally {
1100 |         if (Test-Path -LiteralPath $work) {
1101 |             Remove-Item -LiteralPath $work -Recurse -Force
1102 |         }
1103 |     }
1104 | 
1105 |     if (-not (Test-Path -LiteralPath $outputPath)) {
1106 |         throw "Output DOCX was not created."
1107 |     }
1108 | 
1109 |     Log "SUCCESS"
1110 |     Log "Created: $outputPath"
1111 | 
1112 |     Start-Process explorer.exe -ArgumentList "/select,`"$outputPath`""
1113 |     exit 0
1114 | }
1115 | catch {
1116 |     Log "FAILED"
1117 |     Log $_.Exception.Message
1118 |     Log $_.ScriptStackTrace
1119 | 
1120 |     try {
1121 |         Start-Process notepad.exe -ArgumentList "`"$logPath`""
1122 |     } catch {}
1123 | 
1124 |     exit 1
1125 | }
````


## GTD_Module_Info.dxl — string gtdSystemName       =

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Module_Info.dxl`; ilk satır 147; SHA256 `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b`.

````text
0147 | string gtdSystemName       = gtdInfoModule."System Name" ""
0148 | string gtdPrefix           = gtdInfoModule."Prefix" ""
0149 | string gtdDocumentNumber   = gtdInfoModule."Document Number" ""
0150 | string gtdDocumentRevision = gtdInfoModule."Document Revision" ""
0151 | string gtdProjectName      = gtdInfoModule."Project Name" ""
0152 | string gtdProjectNumber    = gtdInfoModule."Project Number" ""
0153 | string gtdDepartment       = gtdInfoModule."Department" ""
0154 | string gtdWorkPackage      = gtdInfoModule."Work Package" ""
0155 | string gtdSDVILNumber      = gtdInfoModule."SDVIL Number" ""
0156 | string gtdClassification   = gtdInfoModule."Classification" ""
0157 | 
0158 | Date gtdDocumentDate = gtdInfoModule."Document Date"
0159 | 
0160 | if (null gtdDocumentDate)
0161 |     gtdDocumentDate = dateOnly(today)
0162 | 
0163 | // ------------------------------------------------------------
0164 | // Dialog globals
0165 | // ------------------------------------------------------------
0166 | DB gtdInfoDb = create("GTD Module Bilgileri", styleCentered | styleStandard)
````


## GTD_Module_Info.dxl — void gtdSaveInfo(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Module_Info.dxl`; ilk satır 210; SHA256 `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b`.

````text
0210 | void gtdSaveInfo(DB db)
0211 | {
0212 |     string systemName       = gtdTrim(get(gtdSystemNameField))
0213 |     string modulePrefix     = gtdTrim(get(gtdPrefixField))
0214 |     string documentNumber   = gtdTrim(get(gtdDocumentNumberField))
0215 |     string documentRevision = gtdTrim(get(gtdDocumentRevisionField))
0216 |     string projectName      = gtdTrim(get(gtdProjectNameField))
0217 |     string projectNumber    = gtdTrim(get(gtdProjectNumberField))
0218 |     string department       = gtdTrim(get(gtdDepartmentField))
0219 |     string workPackage      = gtdTrim(get(gtdWorkPackageField))
0220 |     string sdvilNumber      = gtdTrim(get(gtdSDVILNumberField))
0221 | 
0222 |     Date documentDate = dateOnly(getDate(gtdDocumentDateField))
0223 | 
0224 |     int classificationIndex = get(gtdClassificationChoice)
0225 |     string classification = ""
0226 | 
0227 |     if (classificationIndex >= 0 && classificationIndex < 4)
0228 |         classification = gtdClassificationChoices[classificationIndex]
0229 | 
0230 |     Buffer missing = create
0231 | 
0232 |     if (systemName == "")       missing += "System Name\n"
0233 |     if (modulePrefix == "")     missing += "DOORS Prefix\n"
0234 |     if (documentNumber == "")   missing += "Document Number\n"
0235 |     if (documentRevision == "") missing += "Document Revision\n"
0236 |     if (null documentDate)      missing += "Document Date\n"
0237 |     if (projectName == "")      missing += "Project Name\n"
0238 |     if (projectNumber == "")    missing += "Project Number\n"
0239 |     if (department == "")       missing += "Department\n"
0240 |     if (classification == "")   missing += "Classification\n"
0241 | 
0242 |     string missingText = stringOf(missing)
0243 | 
0244 |     if (missingText != "") {
0245 |         delete(missing)
0246 |         warningBox "Zorunlu alanlar eksik:\n\n" missingText
0247 |         return
0248 |     }
0249 | 
0250 |     delete(missing)
0251 | 
0252 |     if (!gtdValidPrefix(modulePrefix)) {
0253 |         warningBox "DOORS Prefix gecersiz.\n\nYalnizca A-Z, a-z, 0-9, _ ve - kullanin."
0254 |         return
0255 |     }
0256 | 
0257 |     gtdInfoModule."System Name"       = systemName
0258 |     gtdInfoModule."Prefix"            = modulePrefix
0259 |     gtdInfoModule."Document Number"   = documentNumber
0260 |     gtdInfoModule."Document Revision" = documentRevision
0261 |     gtdInfoModule."Document Date"     = documentDate
0262 |     gtdInfoModule."Project Name"      = projectName
0263 |     gtdInfoModule."Project Number"    = projectNumber
0264 |     gtdInfoModule."Department"        = department
0265 |     gtdInfoModule."Work Package"      = workPackage
0266 |     gtdInfoModule."SDVIL Number"      = sdvilNumber
0267 |     gtdInfoModule."Classification"    = classification
0268 | 
0269 |     noError()
0270 |     save(gtdInfoModule)
0271 |     string saveError = lastError()
0272 | 
0273 |     if (saveError != "") {
0274 |         warningBox "Module kaydedilemedi:\n\n" saveError
0275 |         return
0276 |     }
0277 | 
0278 |     release db
0279 | }
0280 | 
````


## GTD_Install_Open_Trigger.dxl — Project gtdProject =

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Install_Open_Trigger.dxl`; ilk satır 18; SHA256 `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61`.

````text
0018 | Project gtdProject = current Project
0019 | 
0020 | if (null gtdProject) {
0021 |     ack "Once trigger'in kurulacagi projeyi current project yapin."
0022 |     halt
0023 | }
0024 | 
0025 | // Replace the previous trigger with the same agreed identity.
0026 | // A delete error is ignored because it also occurs when no old trigger exists.
0027 | string gtdDeleteError = delete(
0028 |     "GTD_Module_Open_Check",
0029 |     module->all->formal,
0030 |     post,
0031 |     open,
0032 |     10
0033 | )
0034 | 
0035 | Buffer gtdTriggerCode = create
0036 | 
0037 |     gtdTriggerCode += "// ============================================================\n"
0038 |     gtdTriggerCode += "// GTD_Open_Check.dxl\n"
0039 |     gtdTriggerCode += "// Body used by persistent trigger: GTD_Module_Open_Check\n"
0040 |     gtdTriggerCode += "// Scope: current project -> all formal modules\n"
0041 |     gtdTriggerCode += "// Event: post open\n"
0042 |     gtdTriggerCode += "// Priority: 10\n"
````


## GTD_Install_Open_Trigger.dxl — Trigger

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Install_Open_Trigger.dxl`; ilk satır 79; SHA256 `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61`.

````text
0079 |     gtdTriggerCode += "    Trigger gtdTrigger = current()\n"
0080 |     gtdTriggerCode += "\n"
0081 |     gtdTriggerCode += "    // For a post-open module trigger, this obtains the opened module.\n"
0082 |     gtdTriggerCode += "    // The 0 variant also allows correct baseline detection.\n"
0083 |     gtdTriggerCode += "    Module gtdModule = module(gtdTrigger, 0)\n"
0084 |     gtdTriggerCode += "\n"
0085 |     gtdTriggerCode += "    if (null gtdModule)\n"
0086 |     gtdTriggerCode += "        return\n"
0087 |     gtdTriggerCode += "\n"
0088 |     gtdTriggerCode += "    if (baseline(gtdModule))\n"
0089 |     gtdTriggerCode += "        return\n"
0090 |     gtdTriggerCode += "\n"
0091 |     gtdTriggerCode += "    AttrDef adVersion = find(gtdModule, \"GTD Template Version\")\n"
0092 |     gtdTriggerCode += "    AttrDef adFormPath = find(gtdModule, \"GTD Form Path\")\n"
0093 |     gtdTriggerCode += "\n"
0094 |     gtdTriggerCode += "    // Not a GTD module: silently ignore.\n"
0095 |     gtdTriggerCode += "    if (null adVersion || null adFormPath)\n"
0096 |     gtdTriggerCode += "        return\n"
0097 |     gtdTriggerCode += "\n"
0098 |     gtdTriggerCode += "    if (!adVersion.module || !adFormPath.module)\n"
0099 |     gtdTriggerCode += "        return\n"
0100 |     gtdTriggerCode += "\n"
````
