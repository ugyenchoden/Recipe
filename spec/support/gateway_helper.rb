# frozen_string_literal: true

def stub_content_delivery_api
  request(200, response_body)
end

def stub_failed(failure_type)
  body = send("#{failure_type}_failure_body")
  status = failure_type == 'auth_token' ? 401 : 404
  request(status, body)
end

def stub_client_error
  request(429, '')
end

def request(status, body)
  url = "https://cdn.contentful.com/spaces/#{ENV.fetch('SPACE_ID', nil)}/entries?content_type=recipe&skip=0"
  stub_request(:get, url)
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => "Bearer #{ENV.fetch('AUTH_TOKEN', nil)}",
        'User-Agent' => 'Faraday v2.7.5'
      }
    ).to_return(status:, body: body.to_json, headers: {})
end

def invalid_query_body
  {
    sys: { type: 'Error', id: 'InvalidQuery' },
    message:
      'The query you sent was invalid. Probably a filter or ordering specification
       is not applicable to the type of a field.',
    details: { errors: [{ name: 'unknownContentType', value: 'NONEXISTENT' }] }
  }
end

def space_id_failure_body
  {
    sys: {
      type: 'Error', id: 'NotFound'
    },
    message: 'The resource could not be found.'
  }
end

def auth_token_failure_body
  {
    sys: { type: 'Error', id: 'AccessTokenInvalid' },
    message: 'The access token you sent could not be found or is invalid.'
  }
end

def response_body # rubocop:disable Metrics/MethodLength
  {
    total: 4,
    skip: 0,
    limit: 1,
    items: [
      {
        sys: {
          id: 'entry101',
          type: 'Entry',
          revision: 2,
          contentType: {
            sys: {
              type: 'Link',
              linkType: 'ContentType',
              id: 'recipe'
            }
          },
          locale: 'en-US'
        },
        fields: {
          title: 'Ema Datsi',
          photo: {
            sys: {
              type: 'Link',
              linkType: 'Asset',
              id: 'asset101'
            }
          },
          calories: 2000,
          description: 'Ema datsi',
          tags: [
            {
              sys: {
                type: 'Link',
                linkType: 'Entry',
                id: 'tag101'
              }
            }
          ],
          chef: {
            sys: {
              type: 'Link',
              linkType: 'Entry',
              id: 'chef101'
            }
          }
        }
      }
    ],
    includes: {
      Entry: [
        {
          sys: {
            id: 'tag101',
            type: 'Entry',
            revision: 1,
            contentType: {
              sys: {
                type: 'Link',
                linkType: 'ContentType',
                id: 'tag'
              }
            },
            locale: 'en-US'
          },
          fields: {
            name: 'vegan'
          }
        },
        {
          sys: {
            id: 'chef101',
            type: 'Entry',
            revision: 2,
            contentType: {
              sys: {
                type: 'Link',
                linkType: 'ContentType',
                id: 'chef'
              }
            },
            locale: 'en-US'
          },
          fields: {
            name: 'Ugyen Choden'
          }
        }
      ],
      Asset: [
        {
          metadata: {
            tags: []
          },
          sys: {
            id: 'asset101',
            type: 'Asset',
            revision: 1,
            locale: 'en-US'
          },
          fields: {
            title: 'ema datsi',
            file: {
              url: '//test.jpg',
              details: {
                size: 194_737,
                image: {
                  width: 1020,
                  height: 680
                }
              },
              fileName: 'ema datsi.jpg',
              contentType: 'image/jpeg'
            }
          }
        }
      ]
    }
  }
end
