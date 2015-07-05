def octopart_json
  <<-JSON
    {
      "__class__": "SearchResponse",
      "facet_results": {
        "fields": {},
        "queries": {}
      },
      "hits": 24147,
      "msec": 107,
      "request": {
        "__class__": "SearchRequest",
        "facet": {
          "fields": {},
          "queries": []
        },
        "filter": {
          "fields": {},
          "queries": []
        },
        "limit": 10,
        "q": "solid state relay",
        "sortby": "score desc",
        "start": 0,
        "stats": {}
      },
      "results": [
        {
          "__class__": "SearchResult",
          "items": [
              {
              "__class__": "Part",
              "brand": {
                "__class__": "Brand",
                "homepage_url": "http://www.te.com/",
                "name": "TE Connectivity",
                "uid": "c4f105fbe7591336"
              },
              "manufacturer": {
                "__class__": "Manufacturer",
                "homepage_url": "http://www.te.com/",
                "name": "TE Connectivity",
                "uid": "b53d7037929566fa"
              },
              "mpn": "2-1393030-1",
              "octopart_url": "https://octopart.com/2-1393030-1-te+connectivity-41508205",
              "offers": [
                {
                  "__class__": "PartOffer",
                  "eligible_region": null,
                  "factory_lead_days": null,
                  "factory_order_multiple": null,
                  "in_stock_quantity": 353,
                  "is_authorized": true,
                  "is_realtime": false,
                  "last_updated": "2015-07-04T16:49:44Z",
                  "moq": 3,
                  "octopart_rfq_url": null,
                  "on_order_eta": null,
                  "on_order_quantity": null,
                  "order_multiple": null,
                  "packaging": null,
                  "prices": {
                    "USD": [
                      [
                        3,
                        "1.2345"
                      ]
                    ]
                  },
                  "product_url": "https://octopart-clicks.com/click/track?country=US&ak=EXAMPLE_KEY&sig=0bc7b18&sid=5489&ppid=41508205&vpid=123758594&ct=offers",
                  "seller": {
                      "__class__": "Seller",
                      "display_flag": "US",
                      "has_ecommerce": true,
                      "homepage_url": "http://www.verical.com",
                      "id": "2617",
                      "name": "Verical",
                      "uid": "504e954473118389"
                  },
                  "sku": "2-1393030-1"
                }
              ]
            }
          ]
        }
      ]
    }
  JSON
end