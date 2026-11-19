___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "hyperguard_bot_detection",
  "version": 1,
  "securityGroups": [],
  "displayName": "Hyperguard Bot Detection",
  "brand": {
    "id": "hyperguard",
    "displayName": "Hyperguard",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADPUlEQVR42u2bvW/TQBjGn/ecOEnzHTcNaZsF8VEYWBgqwcLAwAADLGxMiAEWxMgfwM7AwsCKWEBCiIGFhW+xgEQZkNqSotKmNKShSfNlH0OF7lxEqGKnsuM7KVLOkV7d/d7H5+e9+Ah9WuPWRY4RaPGbD+hfv9EoT3w3ICgIE+8HggVt8jvnyhDwxoKW/Z0qCLwCKIjZ/+sWUAAUAAVAAVAAFAAFIJAt5KfBakdPQD99Cei00Xl2D+b8hwApIBxB5OxVUDwDyhYQPnnBBwrQQtDPXAYlDfRePYJZnhvcs0digCYNl3PvA9AOHEfo2KltqRX3Y+v2FcAyBxypbutatYr3F0GWyYsMRuOgaHxwBYQjtj7/8c37AChp2C8Mmn0AFEvaQ62V/QAgJzqdFnirMXiwsZQdwMqiHwBkXcsYxdNC/ps18EbNBwBS4wLAqrOMUTovZX/BB06QaaBExjXJspQhwfQBAEpkAWISgHln8XJF19S0NwAk+cPswlpbchINTAZQKXsfgOwBrLUlR49AZhSBPz7A7IK7ZIKGqwBp0eLVFWeDnD4sYFZXAG55vxq0ARj0+R8KQysdQWj2nARz2R/lMKXFGsDyJVDKAK9XASIgFAbpUUCPbVvkWGL7k8iCkjlQ0gDlimDGpL0AAsDr6/4AwDIF8b00g9i1O67E5b+qPtgRYppNAW42vvnT+wqgTN7mAWCZsCplWKuL4NXvsGoV8I0KeH0dvFnvU9sTtJlZRM5ft9lgzwNg2X1iwI0NtO7eGHAh5LC+frJf2dr0/i1AxpTwQAsfnVWB+o59gJYPALDxafeKoLG0/xTAJAXw9WWHNUXGvqHSbXsdAIEmSgKAQ9vqiqHaSwCUK4D0mLQI1hz6iQnRaTW9D0CbPGi/Z9vOBk3yE6XX8T4AuXBBr+t4/56yBSmeHwBMHRIZ62w5j5cajqMc3howlnTNt1M0LvYBXPw3aKgAzM+v7Rshzt2/iP3lvfcBdJ7fhzn3ErxRQ+/tE2dTbzXQffEQvN1E791TdN88Vu8JqhckFAAFQAFQABQABUABUADcAtDvUCECcHxOKeB/R0tH/fCkUsBuDhiP8tFZdXgaAT8+/xuAaiFQxFLMOAAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Detect bot traffic and protect ad spend with Hyperguard. Real-time detection, with the verdict pushed to the dataLayer automatically.",
  "categories": [
    "ADVERTISING",
    "ANALYTICS"
  ],
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "clientId",
    "displayName": "Client ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^hg_[a-zA-Z0-9]{16}$"
        ]
      }
    ],
    "help": "Your Hyperguard Client ID. Find it in your Hyperguard dashboard under Properties \u003e Installation. Format: hg_XXXXXXXXXXXXXXXX"
  },
  {
    "type": "TEXT",
    "name": "apiKey",
    "displayName": "API Key",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^hg_(live|test)_[a-zA-Z0-9]{32}$"
        ]
      }
    ],
    "help": "Your Hyperguard API Key. Generate it in your Hyperguard dashboard under Properties \u003e Installation; it is shown once, so copy it then. Format: hg_live_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  },
  {
    "type": "CHECKBOX",
    "name": "enableSPA",
    "checkboxText": "Enable SPA (Single Page Application) mode",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Enable for React, Vue, Angular, Next.js, or other client-side routed apps. Automatically tracks page navigations via the History API."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Hyperguard Bot Detection — GTM Community Template
// Sets window.HG_CONFIG and injects the tracker script.
// The tracker automatically pushes a 'hyperguard_detection' event to dataLayer.

const injectScript = require('injectScript');
const setInWindow = require('setInWindow');

const TRACKER_URL = 'https://api.hyperguard.app/hg-tracker.min.js';

// Build configuration from template fields
const config = {
  clientId: data.clientId,
  apiKey: data.apiKey
};

if (data.enableSPA) {
  config.enableSPA = true;
}

// Set config on window BEFORE script loads.
// The tracker reads window.HG_CONFIG first (priority over data-* attributes).
setInWindow('HG_CONFIG', config, true);

// Inject the tracker script.
// Cache token 'hyperguardTracker' prevents double-loading on SPA navigations.
injectScript(TRACKER_URL, data.gtmOnSuccess, data.gtmOnFailure, 'hyperguardTracker');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://api.hyperguard.app/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "HG_CONFIG"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Basic tag fires with required fields
  code: |-
    const mockData = {
      clientId: 'hg_abcdefgh12345678',
      apiKey: 'hg_live_abcdefghijklmnopqrstuvwxyz123456',
      enableSPA: false,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('setInWindow', (key, value) => {
      assertThat(key).isEqualTo('HG_CONFIG');
      assertThat(value.clientId).isEqualTo(mockData.clientId);
      assertThat(value.apiKey).isEqualTo(mockData.apiKey);
      assertThat(value.enableSPA).isUndefined();
    });

    mock('injectScript', (url, onSuccess) => {
      assertThat(url).isEqualTo('https://api.hyperguard.app/hg-tracker.min.js');
      onSuccess();
    });

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: Tag fires with SPA mode enabled
  code: |-
    const mockData = {
      clientId: 'hg_abcdefgh12345678',
      apiKey: 'hg_live_abcdefghijklmnopqrstuvwxyz123456',
      enableSPA: true,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('setInWindow', (key, value) => {
      assertThat(value.enableSPA).isTrue();
    });

    mock('injectScript', (url, onSuccess) => {
      onSuccess();
    });

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: Tag calls gtmOnFailure when script fails to load
  code: |-
    const mockData = {
      clientId: 'hg_abcdefgh12345678',
      apiKey: 'hg_live_abcdefghijklmnopqrstuvwxyz123456',
      enableSPA: false,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', (url, onSuccess, onFailure) => {
      onFailure();
    });

    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Hyperguard Bot Detection — GTM Community Template

WHAT IT DOES:
- Sets window.HG_CONFIG with your credentials before the script loads
- Injects hg-tracker.min.js from api.hyperguard.app
- The tracker pushes a 'hyperguard_detection' event to dataLayer on each
  page it tracks: on a visit's first page once Hyperguard has answered, on
  its later pages at once with the visit's verdict (a second event follows
  only if Hyperguard's answer differs)

DATALAYER EVENT:
  event: 'hyperguard_detection'
  hyperguard.sessionId: string
  hyperguard.isBot: boolean

USING THE VERDICT:
Create a Data Layer Variable for hyperguard.isBot and use it in your own
triggers: for example, fire a tag only when it equals false, or block a tag
when it equals true. GTM checks trigger conditions on each event, so the
verdict is available on 'hyperguard_detection' and on every later event of
the page. Tags that fire before it arrives (All Pages, Initialization) cannot
use it.

CONVERSION SIGNAL (optional):
Create a Custom HTML tag containing
  <script>window.hyperguard.trackConversion('purchase');</script>
('purchase', 'signup' or 'lead'). Fire it with a Custom Event trigger on
'hyperguard_detection' plus a condition that matches your confirmation page.
When that event fires the tracker is loaded; trackConversion waits for
Hyperguard's answer before it sends. If a page gets a second event (the
verdict changed), the tag fires twice and the first conversion is recorded.
A flagged session that converts is left out of invalid-traffic reports and its
request evidence is deleted; it does not change how sessions are scored.
The confirmation page must be on the same origin as the tracked site.

PRIVACY:
The tracker keeps the visit's session in localStorage (hg_session,
hg_session_activity) and sets no cookie. It reads browser and device
characteristics for bot detection. Details: https://www.hyperguard.app/privacy
If your consent policy requires it, open this tag's Advanced Settings >
Consent Settings and require additional consent.


