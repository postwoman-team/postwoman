require 'spec_helper'

describe 'Run command' do
  context 'with valid arguments' do
    it 'display all info' do
      expected_output = <<~TEXT
        ┌──────────────────┐
        │ #{'Loader Arguments'.purple} │
        └──────────────────┘
        ┌─────────────────────────────────────────────────────────┐
        │ {                                                       │
        │   "http_method": "get",                                 │
        │   "url": "https://api.github.com/users/hikari-desuyoo", │
        │   "params": {                                           │
        │   },                                                    │
        │   "headers": {                                          │
        │   }                                                     │
        │ }                                                       │
        └─────────────────────────────────────────────────────────┘
        ┌─────────┐
        │ #{'Headers'.purple} │
        └─────────┘
        ┌───────────────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────┐
        │ server                        │ GitHub.com                                                                                 │
        │ date                          │ Wed, 19 Jul 2023 17:44:00 GMT                                                              │
        │ content-type                  │ application/json; charset=utf-8                                                            │
        │ cache-control                 │ public, max-age=60, s-maxage=60                                                            │
        │ vary                          │ Accept, Accept-Encoding, Accept, X-Requested-With                                          │
        │ etag                          │ W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"                       │
        │ last-modified                 │ Mon, 10 Jul 2023 14:03:37 GMT                                                              │
        │ x-github-media-type           │ github.v3; format=json                                                                     │
        │ x-github-api-version-selected │ 2022-11-28                                                                                 │
        │ access-control-expose-headers │ ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, │
        │                               │  X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAu │
        │                               │ th-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprec │
        │                               │ ation, Sunset                                                                              │
        │ access-control-allow-origin   │ *                                                                                          │
        │ strict-transport-security     │ max-age=31536000; includeSubdomains; preload                                               │
        │ x-frame-options               │ deny                                                                                       │
        │ x-content-type-options        │ nosniff                                                                                    │
        │ x-xss-protection              │ 0                                                                                          │
        │ referrer-policy               │ origin-when-cross-origin, strict-origin-when-cross-origin                                  │
        │ content-security-policy       │ default-src 'none'                                                                         │
        │ content-encoding              │ gzip                                                                                       │
        │ x-ratelimit-limit             │ 60                                                                                         │
        │ x-ratelimit-remaining         │ 54                                                                                         │
        │ x-ratelimit-reset             │ 1689791447                                                                                 │
        │ x-ratelimit-resource          │ core                                                                                       │
        │ x-ratelimit-used              │ 6                                                                                          │
        │ accept-ranges                 │ bytes                                                                                      │
        │ content-length                │ 464                                                                                        │
        │ x-github-request-id           │ B3B2:738D:67014C:6C650B:64B820E0                                                           │
        └───────────────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────┘
        ┌────────────────────────────────────────┐
        │ #{'Body'.purple + ' - ' + 'application/json; charset=utf-8'.yellow} │
        └────────────────────────────────────────┘
        ┌──────────────────────────────────────────────────────────────────────────────────────────┐
        │ {                                                                                        │
        │   "login": "Hikari-desuyoo",                                                             │
        │   "id": 66630725,                                                                        │
        │   "node_id": "MDQ6VXNlcjY2NjMwNzI1",                                                     │
        │   "avatar_url": "https://avatars.githubusercontent.com/u/66630725?v=4",                  │
        │   "gravatar_id": "",                                                                     │
        │   "url": "https://api.github.com/users/Hikari-desuyoo",                                  │
        │   "html_url": "https://github.com/Hikari-desuyoo",                                       │
        │   "followers_url": "https://api.github.com/users/Hikari-desuyoo/followers",              │
        │   "following_url": "https://api.github.com/users/Hikari-desuyoo/following{/other_user}", │
        │   "gists_url": "https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}",            │
        │   "starred_url": "https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}",   │
        │   "subscriptions_url": "https://api.github.com/users/Hikari-desuyoo/subscriptions",      │
        │   "organizations_url": "https://api.github.com/users/Hikari-desuyoo/orgs",               │
        │   "repos_url": "https://api.github.com/users/Hikari-desuyoo/repos",                      │
        │   "events_url": "https://api.github.com/users/Hikari-desuyoo/events{/privacy}",          │
        │   "received_events_url": "https://api.github.com/users/Hikari-desuyoo/received_events",  │
        │   "type": "User",                                                                        │
        │   "site_admin": false,                                                                   │
        │   "name": "Hikari",                                                                      │
        │   "company": null,                                                                       │
        │   "blog": "",                                                                            │
        │   "location": null,                                                                      │
        │   "email": null,                                                                         │
        │   "hireable": null,                                                                      │
        │   "bio": null,                                                                           │
        │   "twitter_username": null,                                                              │
        │   "public_repos": 20,                                                                    │
        │   "public_gists": 0,                                                                     │
        │   "followers": 22,                                                                       │
        │   "following": 14,                                                                       │
        │   "created_at": "2020-06-08T14:27:04Z",                                                  │
        │   "updated_at": "2023-07-10T14:03:37Z"                                                   │
        │ }                                                                                        │
        └──────────────────────────────────────────────────────────────────────────────────────────┘
        ┌────────────────┬─────────────────────────────────────────────┐
        │ #{'Status: ' + '200 OK'.green} │ https://api.github.com/users/hikari-desuyoo │
        └────────────────┴─────────────────────────────────────────────┘
      TEXT

      response_headers = { 'server' => 'GitHub.com', 'date' => 'Wed, 19 Jul 2023 17:44:00 GMT',
                           'content-type' => 'application/json; charset=utf-8', 'cache-control' => 'public, max-age=60, s-maxage=60', 'vary' => 'Accept, Accept-Encoding, Accept, X-Requested-With', 'etag' => 'W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"', 'last-modified' => 'Mon, 10 Jul 2023 14:03:37 GMT', 'x-github-media-type' => 'github.v3; format=json', 'x-github-api-version-selected' => '2022-11-28', 'access-control-expose-headers' => 'ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset', 'access-control-allow-origin' => '*', 'strict-transport-security' => 'max-age=31536000; includeSubdomains; preload', 'x-frame-options' => 'deny', 'x-content-type-options' => 'nosniff', 'x-xss-protection' => '0', 'referrer-policy' => 'origin-when-cross-origin, strict-origin-when-cross-origin', 'content-security-policy' => "default-src 'none'", 'content-encoding' => 'gzip', 'x-ratelimit-limit' => '60', 'x-ratelimit-remaining' => '54', 'x-ratelimit-reset' => '1689791447', 'x-ratelimit-resource' => 'core', 'x-ratelimit-used' => '6', 'accept-ranges' => 'bytes', 'content-length' => '464', 'x-github-request-id' => 'B3B2:738D:67014C:6C650B:64B820E0' }
      response_body = '{"login":"Hikari-desuyoo","id":66630725,"node_id":"MDQ6VXNlcjY2NjMwNzI1","avatar_url":"https://avatars.githubusercontent.com/u/66630725?v=4","gravatar_id":"","url":"https://api.github.com/users/Hikari-desuyoo","html_url":"https://github.com/Hikari-desuyoo","followers_url":"https://api.github.com/users/Hikari-desuyoo/followers","following_url":"https://api.github.com/users/Hikari-desuyoo/following{/other_user}","gists_url":"https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}","starred_url":"https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/Hikari-desuyoo/subscriptions","organizations_url":"https://api.github.com/users/Hikari-desuyoo/orgs","repos_url":"https://api.github.com/users/Hikari-desuyoo/repos","events_url":"https://api.github.com/users/Hikari-desuyoo/events{/privacy}","received_events_url":"https://api.github.com/users/Hikari-desuyoo/received_events","type":"User","site_admin":false,"name":"Hikari","company":null,"blog":"","location":null,"email":null,"hireable":null,"bio":null,"twitter_username":null,"public_repos":20,"public_gists":0,"followers":22,"following":14,"created_at":"2020-06-08T14:27:04Z","updated_at":"2023-07-10T14:03:37Z"}'
      response = double(:response,
                        status: 200,
                        reason_phrase: 'OK',
                        body: response_body,
                        headers: response_headers,
                        success?: true)

      faraday_args = [:get, URI.parse('https://api.github.com/users/hikari-desuyoo'), '{}', {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
      expect { attempt_command('run base') }.to output(expected_output).to_stdout
    end

    it 'hides loaders arguments with -nl' do
      expected_output = <<~TEXT
        ┌─────────┐
        │ #{'Headers'.purple} │
        └─────────┘
        ┌───────────────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────┐
        │ server                        │ GitHub.com                                                                                 │
        │ date                          │ Wed, 19 Jul 2023 17:44:00 GMT                                                              │
        │ content-type                  │ application/json; charset=utf-8                                                            │
        │ cache-control                 │ public, max-age=60, s-maxage=60                                                            │
        │ vary                          │ Accept, Accept-Encoding, Accept, X-Requested-With                                          │
        │ etag                          │ W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"                       │
        │ last-modified                 │ Mon, 10 Jul 2023 14:03:37 GMT                                                              │
        │ x-github-media-type           │ github.v3; format=json                                                                     │
        │ x-github-api-version-selected │ 2022-11-28                                                                                 │
        │ access-control-expose-headers │ ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, │
        │                               │  X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAu │
        │                               │ th-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprec │
        │                               │ ation, Sunset                                                                              │
        │ access-control-allow-origin   │ *                                                                                          │
        │ strict-transport-security     │ max-age=31536000; includeSubdomains; preload                                               │
        │ x-frame-options               │ deny                                                                                       │
        │ x-content-type-options        │ nosniff                                                                                    │
        │ x-xss-protection              │ 0                                                                                          │
        │ referrer-policy               │ origin-when-cross-origin, strict-origin-when-cross-origin                                  │
        │ content-security-policy       │ default-src 'none'                                                                         │
        │ content-encoding              │ gzip                                                                                       │
        │ x-ratelimit-limit             │ 60                                                                                         │
        │ x-ratelimit-remaining         │ 54                                                                                         │
        │ x-ratelimit-reset             │ 1689791447                                                                                 │
        │ x-ratelimit-resource          │ core                                                                                       │
        │ x-ratelimit-used              │ 6                                                                                          │
        │ accept-ranges                 │ bytes                                                                                      │
        │ content-length                │ 464                                                                                        │
        │ x-github-request-id           │ B3B2:738D:67014C:6C650B:64B820E0                                                           │
        └───────────────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────┘
        ┌────────────────────────────────────────┐
        │ #{'Body'.purple + ' - ' + 'application/json; charset=utf-8'.yellow} │
        └────────────────────────────────────────┘
        ┌──────────────────────────────────────────────────────────────────────────────────────────┐
        │ {                                                                                        │
        │   "login": "Hikari-desuyoo",                                                             │
        │   "id": 66630725,                                                                        │
        │   "node_id": "MDQ6VXNlcjY2NjMwNzI1",                                                     │
        │   "avatar_url": "https://avatars.githubusercontent.com/u/66630725?v=4",                  │
        │   "gravatar_id": "",                                                                     │
        │   "url": "https://api.github.com/users/Hikari-desuyoo",                                  │
        │   "html_url": "https://github.com/Hikari-desuyoo",                                       │
        │   "followers_url": "https://api.github.com/users/Hikari-desuyoo/followers",              │
        │   "following_url": "https://api.github.com/users/Hikari-desuyoo/following{/other_user}", │
        │   "gists_url": "https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}",            │
        │   "starred_url": "https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}",   │
        │   "subscriptions_url": "https://api.github.com/users/Hikari-desuyoo/subscriptions",      │
        │   "organizations_url": "https://api.github.com/users/Hikari-desuyoo/orgs",               │
        │   "repos_url": "https://api.github.com/users/Hikari-desuyoo/repos",                      │
        │   "events_url": "https://api.github.com/users/Hikari-desuyoo/events{/privacy}",          │
        │   "received_events_url": "https://api.github.com/users/Hikari-desuyoo/received_events",  │
        │   "type": "User",                                                                        │
        │   "site_admin": false,                                                                   │
        │   "name": "Hikari",                                                                      │
        │   "company": null,                                                                       │
        │   "blog": "",                                                                            │
        │   "location": null,                                                                      │
        │   "email": null,                                                                         │
        │   "hireable": null,                                                                      │
        │   "bio": null,                                                                           │
        │   "twitter_username": null,                                                              │
        │   "public_repos": 20,                                                                    │
        │   "public_gists": 0,                                                                     │
        │   "followers": 22,                                                                       │
        │   "following": 14,                                                                       │
        │   "created_at": "2020-06-08T14:27:04Z",                                                  │
        │   "updated_at": "2023-07-10T14:03:37Z"                                                   │
        │ }                                                                                        │
        └──────────────────────────────────────────────────────────────────────────────────────────┘
        ┌────────────────┬─────────────────────────────────────────────┐
        │ #{'Status: ' + '200 OK'.green} │ https://api.github.com/users/hikari-desuyoo │
        └────────────────┴─────────────────────────────────────────────┘
      TEXT

      response_headers = { 'server' => 'GitHub.com', 'date' => 'Wed, 19 Jul 2023 17:44:00 GMT',
                           'content-type' => 'application/json; charset=utf-8', 'cache-control' => 'public, max-age=60, s-maxage=60', 'vary' => 'Accept, Accept-Encoding, Accept, X-Requested-With', 'etag' => 'W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"', 'last-modified' => 'Mon, 10 Jul 2023 14:03:37 GMT', 'x-github-media-type' => 'github.v3; format=json', 'x-github-api-version-selected' => '2022-11-28', 'access-control-expose-headers' => 'ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset', 'access-control-allow-origin' => '*', 'strict-transport-security' => 'max-age=31536000; includeSubdomains; preload', 'x-frame-options' => 'deny', 'x-content-type-options' => 'nosniff', 'x-xss-protection' => '0', 'referrer-policy' => 'origin-when-cross-origin, strict-origin-when-cross-origin', 'content-security-policy' => "default-src 'none'", 'content-encoding' => 'gzip', 'x-ratelimit-limit' => '60', 'x-ratelimit-remaining' => '54', 'x-ratelimit-reset' => '1689791447', 'x-ratelimit-resource' => 'core', 'x-ratelimit-used' => '6', 'accept-ranges' => 'bytes', 'content-length' => '464', 'x-github-request-id' => 'B3B2:738D:67014C:6C650B:64B820E0' }
      response_body = '{"login":"Hikari-desuyoo","id":66630725,"node_id":"MDQ6VXNlcjY2NjMwNzI1","avatar_url":"https://avatars.githubusercontent.com/u/66630725?v=4","gravatar_id":"","url":"https://api.github.com/users/Hikari-desuyoo","html_url":"https://github.com/Hikari-desuyoo","followers_url":"https://api.github.com/users/Hikari-desuyoo/followers","following_url":"https://api.github.com/users/Hikari-desuyoo/following{/other_user}","gists_url":"https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}","starred_url":"https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/Hikari-desuyoo/subscriptions","organizations_url":"https://api.github.com/users/Hikari-desuyoo/orgs","repos_url":"https://api.github.com/users/Hikari-desuyoo/repos","events_url":"https://api.github.com/users/Hikari-desuyoo/events{/privacy}","received_events_url":"https://api.github.com/users/Hikari-desuyoo/received_events","type":"User","site_admin":false,"name":"Hikari","company":null,"blog":"","location":null,"email":null,"hireable":null,"bio":null,"twitter_username":null,"public_repos":20,"public_gists":0,"followers":22,"following":14,"created_at":"2020-06-08T14:27:04Z","updated_at":"2023-07-10T14:03:37Z"}'
      response = double(:response,
                        status: 200,
                        reason_phrase: 'OK',
                        body: response_body,
                        headers: response_headers,
                        success?: true)

      faraday_args = [:get, URI.parse('https://api.github.com/users/hikari-desuyoo'), '{}', {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
      expect { attempt_command('run base -nl') }.to output(expected_output).to_stdout
    end

    it 'hides headers with -nh' do
      expected_output = <<~TEXT
        ┌──────────────────┐
        │ #{'Loader Arguments'.purple} │
        └──────────────────┘
        ┌─────────────────────────────────────────────────────────┐
        │ {                                                       │
        │   "http_method": "get",                                 │
        │   "url": "https://api.github.com/users/hikari-desuyoo", │
        │   "params": {                                           │
        │   },                                                    │
        │   "headers": {                                          │
        │   }                                                     │
        │ }                                                       │
        └─────────────────────────────────────────────────────────┘
        ┌──────────────────┐
        │ #{'Headers (Hidden)'.gray} │
        └──────────────────┘
        ┌────────────────────────────────────────┐
        │ #{'Body'.purple + ' - ' + 'application/json; charset=utf-8'.yellow} │
        └────────────────────────────────────────┘
        ┌──────────────────────────────────────────────────────────────────────────────────────────┐
        │ {                                                                                        │
        │   "login": "Hikari-desuyoo",                                                             │
        │   "id": 66630725,                                                                        │
        │   "node_id": "MDQ6VXNlcjY2NjMwNzI1",                                                     │
        │   "avatar_url": "https://avatars.githubusercontent.com/u/66630725?v=4",                  │
        │   "gravatar_id": "",                                                                     │
        │   "url": "https://api.github.com/users/Hikari-desuyoo",                                  │
        │   "html_url": "https://github.com/Hikari-desuyoo",                                       │
        │   "followers_url": "https://api.github.com/users/Hikari-desuyoo/followers",              │
        │   "following_url": "https://api.github.com/users/Hikari-desuyoo/following{/other_user}", │
        │   "gists_url": "https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}",            │
        │   "starred_url": "https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}",   │
        │   "subscriptions_url": "https://api.github.com/users/Hikari-desuyoo/subscriptions",      │
        │   "organizations_url": "https://api.github.com/users/Hikari-desuyoo/orgs",               │
        │   "repos_url": "https://api.github.com/users/Hikari-desuyoo/repos",                      │
        │   "events_url": "https://api.github.com/users/Hikari-desuyoo/events{/privacy}",          │
        │   "received_events_url": "https://api.github.com/users/Hikari-desuyoo/received_events",  │
        │   "type": "User",                                                                        │
        │   "site_admin": false,                                                                   │
        │   "name": "Hikari",                                                                      │
        │   "company": null,                                                                       │
        │   "blog": "",                                                                            │
        │   "location": null,                                                                      │
        │   "email": null,                                                                         │
        │   "hireable": null,                                                                      │
        │   "bio": null,                                                                           │
        │   "twitter_username": null,                                                              │
        │   "public_repos": 20,                                                                    │
        │   "public_gists": 0,                                                                     │
        │   "followers": 22,                                                                       │
        │   "following": 14,                                                                       │
        │   "created_at": "2020-06-08T14:27:04Z",                                                  │
        │   "updated_at": "2023-07-10T14:03:37Z"                                                   │
        │ }                                                                                        │
        └──────────────────────────────────────────────────────────────────────────────────────────┘
        ┌────────────────┬─────────────────────────────────────────────┐
        │ #{'Status: ' + '200 OK'.green} │ https://api.github.com/users/hikari-desuyoo │
        └────────────────┴─────────────────────────────────────────────┘
      TEXT

      response_headers = { 'server' => 'GitHub.com', 'date' => 'Wed, 19 Jul 2023 17:44:00 GMT',
                           'content-type' => 'application/json; charset=utf-8', 'cache-control' => 'public, max-age=60, s-maxage=60', 'vary' => 'Accept, Accept-Encoding, Accept, X-Requested-With', 'etag' => 'W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"', 'last-modified' => 'Mon, 10 Jul 2023 14:03:37 GMT', 'x-github-media-type' => 'github.v3; format=json', 'x-github-api-version-selected' => '2022-11-28', 'access-control-expose-headers' => 'ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset', 'access-control-allow-origin' => '*', 'strict-transport-security' => 'max-age=31536000; includeSubdomains; preload', 'x-frame-options' => 'deny', 'x-content-type-options' => 'nosniff', 'x-xss-protection' => '0', 'referrer-policy' => 'origin-when-cross-origin, strict-origin-when-cross-origin', 'content-security-policy' => "default-src 'none'", 'content-encoding' => 'gzip', 'x-ratelimit-limit' => '60', 'x-ratelimit-remaining' => '54', 'x-ratelimit-reset' => '1689791447', 'x-ratelimit-resource' => 'core', 'x-ratelimit-used' => '6', 'accept-ranges' => 'bytes', 'content-length' => '464', 'x-github-request-id' => 'B3B2:738D:67014C:6C650B:64B820E0' }
      response_body = '{"login":"Hikari-desuyoo","id":66630725,"node_id":"MDQ6VXNlcjY2NjMwNzI1","avatar_url":"https://avatars.githubusercontent.com/u/66630725?v=4","gravatar_id":"","url":"https://api.github.com/users/Hikari-desuyoo","html_url":"https://github.com/Hikari-desuyoo","followers_url":"https://api.github.com/users/Hikari-desuyoo/followers","following_url":"https://api.github.com/users/Hikari-desuyoo/following{/other_user}","gists_url":"https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}","starred_url":"https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/Hikari-desuyoo/subscriptions","organizations_url":"https://api.github.com/users/Hikari-desuyoo/orgs","repos_url":"https://api.github.com/users/Hikari-desuyoo/repos","events_url":"https://api.github.com/users/Hikari-desuyoo/events{/privacy}","received_events_url":"https://api.github.com/users/Hikari-desuyoo/received_events","type":"User","site_admin":false,"name":"Hikari","company":null,"blog":"","location":null,"email":null,"hireable":null,"bio":null,"twitter_username":null,"public_repos":20,"public_gists":0,"followers":22,"following":14,"created_at":"2020-06-08T14:27:04Z","updated_at":"2023-07-10T14:03:37Z"}'
      response = double(:response,
                        status: 200,
                        reason_phrase: 'OK',
                        body: response_body,
                        headers: response_headers,
                        success?: true)

      faraday_args = [:get, URI.parse('https://api.github.com/users/hikari-desuyoo'), '{}', {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
      expect { attempt_command('run base -nh') }.to output(expected_output).to_stdout
    end
  end

  it 'hides body with -nb' do
    expected_output = <<~TEXT
      ┌──────────────────┐
      │ #{'Loader Arguments'.purple} │
      └──────────────────┘
      ┌─────────────────────────────────────────────────────────┐
      │ {                                                       │
      │   "http_method": "get",                                 │
      │   "url": "https://api.github.com/users/hikari-desuyoo", │
      │   "params": {                                           │
      │   },                                                    │
      │   "headers": {                                          │
      │   }                                                     │
      │ }                                                       │
      └─────────────────────────────────────────────────────────┘
      ┌─────────┐
      │ #{'Headers'.purple} │
      └─────────┘
      ┌───────────────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────┐
      │ server                        │ GitHub.com                                                                                 │
      │ date                          │ Wed, 19 Jul 2023 17:44:00 GMT                                                              │
      │ content-type                  │ application/json; charset=utf-8                                                            │
      │ cache-control                 │ public, max-age=60, s-maxage=60                                                            │
      │ vary                          │ Accept, Accept-Encoding, Accept, X-Requested-With                                          │
      │ etag                          │ W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"                       │
      │ last-modified                 │ Mon, 10 Jul 2023 14:03:37 GMT                                                              │
      │ x-github-media-type           │ github.v3; format=json                                                                     │
      │ x-github-api-version-selected │ 2022-11-28                                                                                 │
      │ access-control-expose-headers │ ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, │
      │                               │  X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAu │
      │                               │ th-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprec │
      │                               │ ation, Sunset                                                                              │
      │ access-control-allow-origin   │ *                                                                                          │
      │ strict-transport-security     │ max-age=31536000; includeSubdomains; preload                                               │
      │ x-frame-options               │ deny                                                                                       │
      │ x-content-type-options        │ nosniff                                                                                    │
      │ x-xss-protection              │ 0                                                                                          │
      │ referrer-policy               │ origin-when-cross-origin, strict-origin-when-cross-origin                                  │
      │ content-security-policy       │ default-src 'none'                                                                         │
      │ content-encoding              │ gzip                                                                                       │
      │ x-ratelimit-limit             │ 60                                                                                         │
      │ x-ratelimit-remaining         │ 54                                                                                         │
      │ x-ratelimit-reset             │ 1689791447                                                                                 │
      │ x-ratelimit-resource          │ core                                                                                       │
      │ x-ratelimit-used              │ 6                                                                                          │
      │ accept-ranges                 │ bytes                                                                                      │
      │ content-length                │ 464                                                                                        │
      │ x-github-request-id           │ B3B2:738D:67014C:6C650B:64B820E0                                                           │
      └───────────────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────┘
      ┌─────────────────────────────────────────────────┐
      │ #{'Body - application/json; charset=utf-8 (Hidden)'.gray} │
      └─────────────────────────────────────────────────┘
      ┌────────────────┬─────────────────────────────────────────────┐
      │ #{'Status: ' + '200 OK'.green} │ https://api.github.com/users/hikari-desuyoo │
      └────────────────┴─────────────────────────────────────────────┘
    TEXT

    response_headers = { 'server' => 'GitHub.com', 'date' => 'Wed, 19 Jul 2023 17:44:00 GMT',
                         'content-type' => 'application/json; charset=utf-8', 'cache-control' => 'public, max-age=60, s-maxage=60', 'vary' => 'Accept, Accept-Encoding, Accept, X-Requested-With', 'etag' => 'W/"ad5491903690ef8a37096a9ead78feb99ffc0dfa036b78eab2e4bc32c8904e86"', 'last-modified' => 'Mon, 10 Jul 2023 14:03:37 GMT', 'x-github-media-type' => 'github.v3; format=json', 'x-github-api-version-selected' => '2022-11-28', 'access-control-expose-headers' => 'ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset', 'access-control-allow-origin' => '*', 'strict-transport-security' => 'max-age=31536000; includeSubdomains; preload', 'x-frame-options' => 'deny', 'x-content-type-options' => 'nosniff', 'x-xss-protection' => '0', 'referrer-policy' => 'origin-when-cross-origin, strict-origin-when-cross-origin', 'content-security-policy' => "default-src 'none'", 'content-encoding' => 'gzip', 'x-ratelimit-limit' => '60', 'x-ratelimit-remaining' => '54', 'x-ratelimit-reset' => '1689791447', 'x-ratelimit-resource' => 'core', 'x-ratelimit-used' => '6', 'accept-ranges' => 'bytes', 'content-length' => '464', 'x-github-request-id' => 'B3B2:738D:67014C:6C650B:64B820E0' }
    response_body = '{"login":"Hikari-desuyoo","id":66630725,"node_id":"MDQ6VXNlcjY2NjMwNzI1","avatar_url":"https://avatars.githubusercontent.com/u/66630725?v=4","gravatar_id":"","url":"https://api.github.com/users/Hikari-desuyoo","html_url":"https://github.com/Hikari-desuyoo","followers_url":"https://api.github.com/users/Hikari-desuyoo/followers","following_url":"https://api.github.com/users/Hikari-desuyoo/following{/other_user}","gists_url":"https://api.github.com/users/Hikari-desuyoo/gists{/gist_id}","starred_url":"https://api.github.com/users/Hikari-desuyoo/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/Hikari-desuyoo/subscriptions","organizations_url":"https://api.github.com/users/Hikari-desuyoo/orgs","repos_url":"https://api.github.com/users/Hikari-desuyoo/repos","events_url":"https://api.github.com/users/Hikari-desuyoo/events{/privacy}","received_events_url":"https://api.github.com/users/Hikari-desuyoo/received_events","type":"User","site_admin":false,"name":"Hikari","company":null,"blog":"","location":null,"email":null,"hireable":null,"bio":null,"twitter_username":null,"public_repos":20,"public_gists":0,"followers":22,"following":14,"created_at":"2020-06-08T14:27:04Z","updated_at":"2023-07-10T14:03:37Z"}'
    response = double(:response,
                      status: 200,
                      reason_phrase: 'OK',
                      body: response_body,
                      headers: response_headers,
                      success?: true)

    faraday_args = [:get, URI.parse('https://api.github.com/users/hikari-desuyoo'), '{}', {}]
    allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
    expect { attempt_command('run base -nb') }.to output(expected_output).to_stdout
  end

  it 'prints out error if loader does not exist' do
    expected_output = <<~TEXT
      #{"No loader found: 'MyLoader'".red}
    TEXT
    expect { attempt_command('run my_loader') }.to output(expected_output).to_stdout
  end

  it 'outputs error message if loader name is not provided' do
    expected_output = <<~TEXT
      #{"Missing #1 positional argument: 'loader_name'".red}
    TEXT
    expect { attempt_command('run') }.to output(expected_output).to_stdout
  end
end
