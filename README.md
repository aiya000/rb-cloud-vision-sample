An experience for Google Cloud Vision API

## Requirements

Get your credential key to make `./key.json`.

```shell-session
$ gcloud iam service-accounts create vision-quickstart --project <your-project-id}
$ gcloud iam service-accounts keys create key.json --iam-account vision-quickstart@<your-project-id>.iam.gserviceaccount.com
$ export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

Please also see [the document](https://cloud.google.com/docs/authentication/production#auth-cloud-implicit-go).

## Execute

```shell-session
$ bundle exec ruby main.rb
```
