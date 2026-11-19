# Hyperguard Bot Detection: Google Tag Manager template

This tag loads the Hyperguard tracker from Google Tag Manager. Hyperguard checks each visit for bots and pushes its verdict to the dataLayer, where your own triggers can use it.

## Set it up

1. In GTM, open **Templates → Tag Templates → Search Gallery** and add **Hyperguard Bot Detection**.
2. Create a tag from it and fill in your **Client ID** and **API Key**. Both are in the Hyperguard console, on your property's **Installation** tab. Generate the API key there: it is shown once, so copy it then.
3. If your site is a single-page app (React, Vue, Next.js and similar), tick **Enable SPA mode**, so route changes count as pageviews.
4. Set the trigger to **All Pages**, then publish your container.

## The verdict in the dataLayer

On each page it tracks, the tracker pushes:

```js
{ event: 'hyperguard_detection', hyperguard: { sessionId: '...', isBot: false } }
```

On a visit's first page it arrives once Hyperguard has answered. On later pages it arrives at once, with the verdict the visit already received; a second event follows only if Hyperguard's answer differs.

Create a **Data Layer Variable** for `hyperguard.isBot` to use the verdict in your own triggers. Tags that fire before the event arrives (**All Pages**, **Initialization**) cannot use it.

## Privacy

The tracker keeps the visit's session in localStorage (`hg_session`, `hg_session_activity`) and sets no cookie. It reads browser and device characteristics for bot detection. Details: https://www.hyperguard.app/privacy

If your consent policy requires it, open the tag's **Advanced Settings → Consent Settings** and require additional consent.

## About

Hyperguard: https://www.hyperguard.app
