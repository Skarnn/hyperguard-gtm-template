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
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADPUlEQVR42u2bvW/TQBjGn/ecOEnzHTcNaZsF8VEYWBgqwcLAwAADLGxMiAEWxMgfwM7AwsCKWEBCiIGFhW+xgEQZkNqSotKmNKShSfNlH0OF7lxEqGKnsuM7KVLOkV7d/d7H5+e9+Ah9WuPWRY4RaPGbD+hfv9EoT3w3ICgIE+8HggVt8jvnyhDwxoKW/Z0qCLwCKIjZ/+sWUAAUAAVAAVAAFAAFIJAt5KfBakdPQD99Cei00Xl2D+b8hwApIBxB5OxVUDwDyhYQPnnBBwrQQtDPXAYlDfRePYJZnhvcs0digCYNl3PvA9AOHEfo2KltqRX3Y+v2FcAyBxypbutatYr3F0GWyYsMRuOgaHxwBYQjtj7/8c37AChp2C8Mmn0AFEvaQ62V/QAgJzqdFnirMXiwsZQdwMqiHwBkXcsYxdNC/ps18EbNBwBS4wLAqrOMUTovZX/BB06QaaBExjXJspQhwfQBAEpkAWISgHln8XJF19S0NwAk+cPswlpbchINTAZQKXsfgOwBrLUlR49AZhSBPz7A7IK7ZIKGqwBp0eLVFWeDnD4sYFZXAG55vxq0ARj0+R8KQysdQWj2nARz2R/lMKXFGsDyJVDKAK9XASIgFAbpUUCPbVvkWGL7k8iCkjlQ0gDlimDGpL0AAsDr6/4AwDIF8b00g9i1O67E5b+qPtgRYppNAW42vvnT+wqgTN7mAWCZsCplWKuL4NXvsGoV8I0KeH0dvFnvU9sTtJlZRM5ft9lgzwNg2X1iwI0NtO7eGHAh5LC+frJf2dr0/i1AxpTwQAsfnVWB+o59gJYPALDxafeKoLG0/xTAJAXw9WWHNUXGvqHSbXsdAIEmSgKAQ9vqiqHaSwCUK4D0mLQI1hz6iQnRaTW9D0CbPGi/Z9vOBk3yE6XX8T4AuXBBr+t4/56yBSmeHwBMHRIZ62w5j5cajqMc3howlnTNt1M0LvYBXPw3aKgAzM+v7Rshzt2/iP3lvfcBdJ7fhzn3ErxRQ+/tE2dTbzXQffEQvN1E791TdN88Vu8JqhckFAAFQAFQABQABUABUADcAtDvUCECcHxOKeB/R0tH/fCkUsBuDhiP8tFZdXgaAT8+/xuAaiFQxFLMOAAAAABJRU5ErkJggg=="
  },
  "description": "Detect bot traffic and protect ad spend with Hyperguard. Identifies automated visitors in real-time using browser fingerprinting. Cookie-free, GDPR-friendly. Results are pushed to dataLayer as the hyperguard_detection event.",
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
        "args": ["^hg_[a-zA-Z0-9]{16}$"]
      }
    ],
    "help": "Your Hyperguard Client ID. Find it in your Hyperguard dashboard under Properties > Installation. Format: hg_XXXXXXXXXXXXXXXX"
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
        "args": ["^hg_(live|test)_[a-zA-Z0-9]{32}$"]
      }
    ],
    "help": "Your Hyperguard API Key. Find it in your Hyperguard dashboard under Properties > Installation. Format: hg_live_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  },
  {
    "type": "CHECKBOX",
    "name": "enableSPA",
    "checkboxText": "Enable SPA (Single Page Application) mode",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Enable for React, Vue, Angular, Next.js, or other client-side routed apps. Automatically tracks page navigations via the History API."
  },
  {
    "type": "CHECKBOX",
    "name": "enableDebug",
    "checkboxText": "Enable debug logging",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Logs detection activity to the browser console for troubleshooting. Disable in production."
  },
  {
    "type": "GROUP",
    "name": "advancedSettings",
    "displayName": "Advanced Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "apiEndpoint",
        "displayName": "Custom API Endpoint (optional)",
        "simpleValueType": true,
        "help": "Override the default API endpoint (api.hyperguard.app). Leave blank for standard operation.",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": ["^(https://.*|)$"]
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Hyperguard Bot Detection — GTM Community Template
// Sets window.HG_CONFIG and injects the tracker script.
// The tracker automatically pushes a 'hyperguard_detection' event to dataLayer.

const log = require('logToConsole');
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

if (data.enableDebug) {
  config.enableDebug = true;
}

if (data.apiEndpoint) {
  config.apiEndpoint = data.apiEndpoint;
}

// Set config on window BEFORE script loads.
// The tracker reads window.HG_CONFIG first (priority over data-* attributes).
setInWindow('HG_CONFIG', config, true);

if (data.enableDebug) {
  log('Hyperguard: Loading tracker with config:', config);
}

// Inject the tracker script.
// Cache token 'hyperguardTracker' prevents double-loading on SPA navigations.
injectScript(TRACKER_URL, data.gtmOnSuccess, data.gtmOnFailure, 'hyperguardTracker');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "vpiVersion": "1"
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
        "publicId": "access_globals",
        "vpiVersion": "1"
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
                  { "type": 1, "string": "key" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" },
                  { "type": 1, "string": "execute" }
                ],
                "mapValue": [
                  { "type": 1, "string": "HG_CONFIG" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": false }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "key" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" },
                  { "type": 1, "string": "execute" }
                ],
                "mapValue": [
                  { "type": 1, "string": "hyperguard" },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": false }
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
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "vpiVersion": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
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
      enableDebug: false,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('setInWindow', (key, value) => {
      assertThat(key).isEqualTo('HG_CONFIG');
      assertThat(value.clientId).isEqualTo(mockData.clientId);
      assertThat(value.apiKey).isEqualTo(mockData.apiKey);
      assertThat(value.enableSPA).isUndefined();
      assertThat(value.enableDebug).isUndefined();
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
      enableDebug: false,
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

- name: Tag fires with debug mode
  code: |-
    const mockData = {
      clientId: 'hg_abcdefgh12345678',
      apiKey: 'hg_test_abcdefghijklmnopqrstuvwxyz123456',
      enableSPA: false,
      enableDebug: true,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('setInWindow', (key, value) => {
      assertThat(value.enableDebug).isTrue();
    });

    mock('injectScript', (url, onSuccess) => {
      onSuccess();
    });

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('logToConsole').wasCalled();

- name: Tag fires with custom API endpoint
  code: |-
    const mockData = {
      clientId: 'hg_abcdefgh12345678',
      apiKey: 'hg_live_abcdefghijklmnopqrstuvwxyz123456',
      enableSPA: false,
      enableDebug: false,
      apiEndpoint: 'https://custom.example.com/v1/events',
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('setInWindow', (key, value) => {
      assertThat(value.apiEndpoint).isEqualTo('https://custom.example.com/v1/events');
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
      enableDebug: false,
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', (url, onSuccess, onFailure) => {
      onFailure();
    });

    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Hyperguard Bot Detection — GTM Community Template v1.0.0
Tracker version: 2.24.1

WHAT IT DOES:
- Sets window.HG_CONFIG with your credentials before the script loads
- Injects hg-tracker.min.js from api.hyperguard.app
- The tracker automatically pushes a 'hyperguard_detection' event to dataLayer

DATALAYER EVENT:
  event: 'hyperguard_detection'
  hyperguard.sessionId: string
  hyperguard.isBot: boolean

BLOCKING BOT TRAFFIC:
Create a Custom Event trigger on 'hyperguard_detection' with condition
hyperguard.isBot equals true, then add it as a blocking trigger on your ad tags.

PRIVACY:
No cookies used. Data stored in localStorage only.
Operates under GDPR legitimate interest (Art 6(1)(f)) for security/fraud prevention.
