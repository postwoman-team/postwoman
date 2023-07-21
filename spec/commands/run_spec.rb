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

    it 'hides almost everything with -nl -nh -nb' do
      expected_output = <<~TEXT
        ┌──────────────────┐
        │ #{'Headers (Hidden)'.gray} │
        └──────────────────┘
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
      expect { attempt_command('run base -nb -nh -nl') }.to output(expected_output).to_stdout
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

  context 'prints out error' do
    it 'if loader does not exist' do
      expected_output = <<~TEXT
        #{"No loader found: 'MyLoader'".red}
      TEXT
      expect { attempt_command('run my_loader') }.to output(expected_output).to_stdout
    end

    it 'if loader name is not provided' do
      expected_output = <<~TEXT
        #{"Missing #1 positional argument: 'loader_name'".red}
      TEXT
      expect { attempt_command('run') }.to output(expected_output).to_stdout
    end

    it 'if loader couldnt be loaded properly' do
      class MockLoader
      end

      expected_output = <<~TEXT
        #{"Your loader 'MockLoader' raised an exception:".red}
        /home/hikari/projetos/postwoman/utils/commands/run.rb:16:in `initialize': #{"wrong number of arguments (given 1, expected 0) (ArgumentError)".bold}
                from /home/hikari/projetos/postwoman/utils/commands/run.rb:16:in `new'
                from /home/hikari/projetos/postwoman/utils/commands/run.rb:16:in `execute'
                from /home/hikari/projetos/postwoman/utils/attempt_command.rb:10:in `attempt_command'
                from /home/hikari/projetos/postwoman/spec/commands/run_spec.rb:411:in `block (4 levels) in <top (required)>'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/matchers/built_in/output.rb:150:in `capture'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/matchers/built_in/output.rb:20:in `matches?'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/expectations/handler.rb:51:in `block in handle_matcher'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/expectations/handler.rb:27:in `with_matcher'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/expectations/handler.rb:48:in `handle_matcher'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/expectations/expectation_target.rb:65:in `to'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-expectations-3.12.3/lib/rspec/expectations/expectation_target.rb:139:in `to'
                from /home/hikari/projetos/postwoman/spec/commands/run_spec.rb:411:in `block (3 levels) in <top (required)>'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:263:in `instance_exec'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:263:in `block in run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:511:in `block in with_around_and_singleton_context_hooks'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:468:in `block in with_around_example_hooks'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/hooks.rb:486:in `block in run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/hooks.rb:624:in `run_around_example_hooks_for'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/hooks.rb:486:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:468:in `with_around_example_hooks'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:511:in `with_around_and_singleton_context_hooks'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example.rb:259:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:646:in `block in run_examples'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:642:in `map'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:642:in `run_examples'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:607:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:608:in `block in run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:608:in `map'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/example_group.rb:608:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:121:in `block (3 levels) in run_specs'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:121:in `map'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:121:in `block (2 levels) in run_specs'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/configuration.rb:2070:in `with_suite_hooks'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:116:in `block in run_specs'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/reporter.rb:74:in `report'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:115:in `run_specs'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:89:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:71:in `run'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/lib/rspec/core/runner.rb:45:in `invoke'
                from /home/hikari/.rvm/gems/ruby-3.0.0/gems/rspec-core-3.12.2/exe/rspec:4:in `<top (required)>'
                from /home/hikari/.rvm/gems/ruby-3.0.0/bin/rspec:23:in `load'
                from /home/hikari/.rvm/gems/ruby-3.0.0/bin/rspec:23:in `<main>'
                from /home/hikari/.rvm/gems/ruby-3.0.0/bin/ruby_executable_hooks:22:in `eval'
                from /home/hikari/.rvm/gems/ruby-3.0.0/bin/ruby_executable_hooks:22:in `<main>'
      TEXT

      allow(Loaders).to receive(:class_eval).with('MockLoader').and_return(MockLoader)

      expect { attempt_command('run mock_loader') }.to output(expected_output).to_stdout
    end
  end
end
