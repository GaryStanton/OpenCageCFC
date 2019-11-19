# OpenCage CFC


OpenCageCFC provides a wrapper for the OpenCage Geocoder API
The opencage API is a commercial product with a generous free tier. 
Obtain an API key from https://opencagedata.com/users/sign_up.


## Installation
```js
box install opencage
```

### Usage
instantiate the component and pass your API key to the constructor. 
You may do this standalone:
```cfc
var opencage  = new opencage.models.opencage(
    aipKey = 'YOURAPIKEY'
);
```
or with ColdBox:
```cfc
var opencage  = getInstance("opencage@opencage");
```
alternatively inject it directly into your handler
```cfc
property name="opencage" inject="opencage@opencage";
```

When using with ColdBox, you'll want to insert your API key into your module settings:

```cfc
opencage = {
    apiKey = getSystemSetting( "OPENCAGE_KEY", "" )
}
```


### Query
The opencage CFC wrapper contains a single method, `query`, which will return the response from the opencage API.

```cfc
data = opencage.query(
    	q = 'British Library, 96 Euston Road, London NW1 2DB'
    ,   responseFormat = 'json'
);
```

The query method accepts the following parameters:
| parameter |  |
| --- | --- |
|`q`                | The query string to be geocoded - a latitude, longitude or a placename/address.<br> When reverse geocoding the query should be in latitude, longitude order in decimal format. For example: 51.952659, 7.632473. There is no reason to send more than six or seven digits past the decimal as that then gets down to the precision of a centimeter. If impossible coordinates are supplied you will receive a 400 invalid coordinates as the response code in the status section of the response.|
|`responseFormat`   | The response format (json|geojson|xml|map). Defaults to json.
|`abbrv`            | If true, attempt to abbreviate and shorten the formatted string we return.|
|`add_request`      | If true, the various request parameters are added to the response for ease of debugging.|
|`bounds`           | Used only for forward geocoding. This value will restrict the possible results to a defined bounding box.<br> The value of the bounds parameter should be specified as two coordinate points forming the south-west and north-east corners of a bounding box. For example: bounds=-0.563160,51.280430,0.278970,51.683979 (min lon, min lat, max lon, max lat). <br> Values that are not valid coordinates are ignored. |
|`countrycode`      | Used only for forward geocoding. Restricts results to the specified country/territory or countries.<br> The country code is a two letter code as defined by the ISO 3166-1 Alpha 2 standard. E.g. gb for the United Kingdom, fr for France, us for United States.<br> Non-two letter country codes are ignored.<br> You can specify multiple country codes by supplying a comma separated list. For example countrycode=ca,us would limit results to either the United States or Canada.<br> Please note, many territories have their own ISO 3116-1 codes, despite being part of another country. An example is Puerto Rico which has ISO code PR, despite being part of the United States, US. In the components portion of results we return both.<br> Many parts of the world have complex or even disputed political structures and/or share postal systems with another country, and thus may be treated as a single or multiple country by some of the geocoders we rely upon. It may make sense to specify multiple country codes.<br> As an example, when searching for locations on the island of Aruba - technically a constituent country of the Kingdom of the Netherlands - we will do better if you specify countrycode=aw,nl rather than just countrycode=aw. |
|`jsonp`            | Wraps the returned JSON with a function name. |
|`language`         | An IETF format language code (such as es for Spanish or pt-BR for Brazilian Portuguese), or native in which case we will attempt to return the response in the local language(s). <br> Please note, setting the language parameter does NOT mean results will only be returned in the specified language. Instead it means we will attempt to favour results in that language.|
|`limit`            | The maximum number of results we should return. Default is 10. Maximum allowable value is 100. |
|`min_confidence`   | An integer from 1-10. Only results with at least this confidence will be returned.|
|`no_annotations`   | When true results will not contain annotations. |
|`no_dedupe`        | When true results will not be deduplicated. |
|`no_record`        | When true the query contents are not logged. |
|`pretty`           | When true results are 'pretty' printed for easier reading. Useful for debugging. |
|`proximity`        | Used only for forward geocoding. Provides the geocoder with a hint to bias results in favour of those closer to the specified location. Please note though, this is just one of many factors in the internal scoring we use for ranking results. The value is a point with latitude, longitude coordinates in decimal format. For example: 51.952659, 7.632473 <br> Values that are not valid coordinates are ignored. |
|`roadinfo`         | When true the behaviour of the geocoder is changed to attempt to match the nearest road (as opposed to address). If possible we also fill additional information in the roadinfo annotation. |