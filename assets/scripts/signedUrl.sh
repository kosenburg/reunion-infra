#!/bin/bash

gcloud iam service-accounts keys create KEY.json --iam-account=reunion-download-acct@dulcet-elevator-433022-g0.iam.gserviceaccount.com
gcloud storage sign-url gs://gcp-ko-ru-blobs/family_tree.png --private-key-file=KEY.json --duration=7d --project=dulcet-elevator-433022-g0 > results.txt
rm -rf KEY.json