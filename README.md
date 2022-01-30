# terraform-wireguard


install wg cli `brew install wireguard-tools`

1. Generate private key for server. Call this server private key.

```bash
wg genkey | tee > private.key
```

2. Extract public key from that. Call this server public key.

```bash
cat private.key | wg pubkey
```

3. Set terraform variables with these generated pub/priv keys


4. Put server public key in your client config.


Example Client Config

```
[Interface]
PrivateKey = CLIENT_PRIVATE_KEY
Address = 10.10.10.2/32
DNS = 1.1.1.1, 1.0.0.1

[Peer]
PublicKey =  SERVER_PUBLIC_KEY
AllowedIPs = 1.0.0.0/8, 2.0.0.0/8, 3.0.0.0/8, 4.0.0.0/6, 8.0.0.0/7, 11.0.0.0/8, 12.0.0.0/6, 16.0.0.0/4, 32.0.0.0/3, 64.0.0.0/2, 128.0.0.0/3, 160.0.0.0/5, 168.0.0.0/6, 172.0.0.0/12, 172.32.0.0/11, 172.64.0.0/10, 172.128.0.0/9, 173.0.0.0/8, 174.0.0.0/7, 176.0.0.0/4, 192.0.0.0/9, 192.128.0.0/11, 192.160.0.0/13, 192.169.0.0/16, 192.170.0.0/15, 192.172.0.0/14, 192.176.0.0/12, 192.192.0.0/10, 193.0.0.0/8, 194.0.0.0/7, 196.0.0.0/6, 200.0.0.0/5, 208.0.0.0/4, 8.8.8.8/32
Endpoint = SERVER_IP:51820
```


This [guide](https://www.digitalocean.com/community/tutorials/how-to-set-up-wireguard-on-ubuntu-20-04) may or may not contain useful information.


## Digital Ocean Regions

| Geographic Location          | Slug (For API) |
|------------------------------|----------------|
| New York City, United States | nyc3           |
| Amsterdam, the Netherlands   | ams3           |
| San Francisco, United States | sfo3           |
| London, United Kingdom       | lon1           |
| Frankfurt, Germany           | fra1           |
| Toronto, Canada              | tor1           |
| Bangalore, India             | blr1           |


## AWS Regions

| GeographicLocation  |   Region Name   |
|---------------------|-----------------|
|  Stockholm, Sweden  |  eu-north-1     |
|  Mumbai, India      |  ap-south-1     |
|  Paris, France      |  eu-west-3      |
|  London, England    |  eu-west-2      |
|  Ireland            |  eu-west-1      |
|  Osaka, Japan       |  ap-northeast-3 |
|  Seoul, South Korea |  ap-northeast-2 |
|  Tokyo, Japan       |  ap-northeast-1 |
|  São Paulo, Brazil  |  sa-east-1      |
|  Canada (Central)   |  ca-central-1   |
|  Singapore          |  ap-southeast-1 |
|  Sydney, Australia  |  ap-southeast-2 |
|  Frankfurt, Germany |  eu-central-1   |
|  Virginia, US       |  us-east-1      |
|  Ohio, US           |  us-east-2      |
|  California, US     |  us-west-1      |
|  Oregon, US         |  us-west-2      |
