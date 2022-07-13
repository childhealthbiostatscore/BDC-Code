#!/bin/bash
# Move to base folder
cd /Volumes/PEDS/RI\ Biostatistics\ Core/Shared/Shared\ Projects/Laura/BDC/Projects/Viral\ Shah/JDRF
# Move and rename
find "Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/" -type f -iname '*.pdf' -exec sh -c '
    path="${1%/*}"; filename="${1##*/}";
    cp -nv "${1}" "Data_Cleaned/pdfs/${path##*/} ${filename}" ' sh_cp {} \;
