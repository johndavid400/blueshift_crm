# Blueshift CRM (Ruby)

A lightweight Ruby client for the Blueshift CRM API.

## Install

```bash
bundle add blueshift_crm
```

### Add ENV variables for API keys:

```bash
export BLUESHIFT_SITE_ID=""
export BLUESHIFT_EVENT_API_KEY=""
export BLUESHIFT_USER_API_KEY=""
export BLUESHIFT_API_PASSWORD=""
```

### Optional:

```bash
export BLUESHIFT_REGION=""
```

## Usage:

```bash
# create a client instance:
client = BlueshiftCRM::Client.new
```
#### Adapters:
```bash
client.adapters.list
```

#### Campaigns:
```bash
client.campaigns.list
```

#### Custom User Lists:
```bash
client.custom_user_lists.seed_lists
```

#### Customers:
```bash
client.customers.get(uuid: "")
```

#### Events:
```bash
client.events.history(event: "")
```

#### Segments:
```bash
client.segments.list
```
