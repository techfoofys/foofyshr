require "refile/s3"

aws = {
  access_key_id: "AKIAJJR22GYU5XNTC7XA",
  secret_access_key: "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",
  region: "sa-east-1",
  bucket: "soumit-blog",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
