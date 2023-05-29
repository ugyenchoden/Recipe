# frozen_string_literal: true

def stub_content_delivery_api
  stub_request(:get, "https://cdn.contentful.com/spaces/#{ENV.fetch('SPACE_ID', nil)}/entries?content_type=recipe&skip=0").
    with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => "Bearer #{ENV.fetch('AUTH_TOKEN', nil)}",
        'User-Agent' => 'Faraday v2.7.5'
      }
    ).to_return(status: 200, body: response_body.to_json, headers: {})
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
              url: '//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg',
              details: {
                size: 194737,
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
