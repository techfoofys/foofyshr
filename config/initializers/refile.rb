require "refile/s3"

aws = {
  access_key_id: "Your-access-key",
  secret_access_key: "secreat-key",
  region: "sa-east-1",
  bucket: "bucket-name",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
