# Farmers Market API
I designed this Rails application as a solo project to provide a microservice architecture offering a variety of endpoints for discovering and managing local Farmers' Markets and Vendors, learning some crucial concepts for building JSON APIs along the way.

## Project Overview
Farmers Market serves as a backend API-only application, catering to users seeking information about markets and vendors in their locality. With a strong foundation in microservice architecture, the project exposes a range of ReSTful and non-RESTful endpoints. Through this API, users can find markets, view vendor details, create vendors, manage associations between markets and vendors, and more.

---
### Languages, Frameworks, and Tools used
- **Building:** Ruby, Rails, and some SQL
- **Testing:** RSpec, ShouldaMatchers, Webmock, VCR
- **Database:** PostgreSQL
- **Consuming API:** Faraday HTTP client library

### Accomplishments
This is my favorite project that I've undertaken so far and one that I believe challenged me to grow the most in such a short amount of time. I spent about 35 hours building in the span of 4 days and achieved the following:
- Implemented a Micro Service Architecture to manage farmers' markets and vendors.
- Designed robust testing to develop and expose a comprehensive API for market, vendor, and nearby ATM information.
- Leveraged serializer to format JSON responses efficiently.
- Implemented ActiveRecord Callbacks to streamline data validation.
- Employed exception-handling techniques, including rescuing errors and raising custom errors, to provide clear and informative error responses.
- Consumed a TomTom maps/navigation API and translated its use into a new endpoint to find ATMs near a Market's location.

### Project Challenges
Being my first time creating a microservice JSON API, as well as using error exception handlers, serializers, and ActiveRecord callbacks, this project proved to be one of the most challenging, but rewarding projects for me yet. The initial challenges for me were:
- One of the initial hurdles was mastering the effective use of serializers to format JSON responses. This task involved configuring serializers for diverse data types, handling associations between different models, and ensuring a consistent and user-friendly response format. After mastering the fundamentals, I leveraged the json-serializer gem.
- Incorporating exception handlers for the first time introduced me to a new layer of complexity. Determining when to raise custom errors, handling different error scenarios gracefully, and providing informative error messages required thoughtful consideration.
- Developing a variety of endpoints, both RESTful and non-RESTful, was a challenging task. Ensuring each endpoint correctly interacted with the data and met the API's purpose while adhering to best practices was a significant challenge. 

---

### Features
> RESTful Endpoints:
> - Market Endpoints:
>   - Get all markets
>   - Get one market
>   - Get all vendors for a market
> - Vendor Endpoints:
>   - Get one vendor
>   - Create a vendor
>   - Update a vendor
>   - Delete a vendor
> - MarketVendor Endpoints:
>   - Create a market_vendor
>   - Delete a market_vendor

> Non-RESTful Endpoints:
> - ActiveRecord Endpoint: Get all markets within a city or state that match a string fragment
> - Consume API Endpoint: Get ATMs close to a market's location, leveraging the [TomTom API](https://developer.tomtom.com/)

### Sneak Peeks:

#### Vendor Model, Controller, and Spec
<img width="1800" alt="Vendors controller, model, and spec" src="https://github.com/westonio/farmers_market_api/assets/117330008/e59e38f3-c0b5-4296-a7ae-dcc8cc6aac64">

#### MarketVendors Controller and Spec
<img width="1800" alt="Market Vendors controller and spec" src="https://github.com/westonio/farmers_market_api/assets/117330008/f2941111-6004-49bc-9ac6-7706475a754f">

#### Market Model, #search Controller Action, and Spec
<img width="1800" alt="Markets model, controller #search, and spec" src="https://github.com/westonio/farmers_market_api/assets/117330008/ec811a46-80ea-403d-82ec-222d64511d22">



