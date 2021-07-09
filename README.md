# TurtleCoin

### what is needed to get started?
Download and install <a href="https://github.com/turtlecoin/turtlecoin">https://github.com/turtlecoin/turtlecoin</a>

More info: <a href="https://turtlecoin.github.io/wallet-api-docs/">https://turtlecoin.github.io/wallet-api-docs/</a>

### Config
The config file is located in the `data` directory. 
```
{
    "ip": "http://",
    "daemonHost": "127.0.0.1",
    "daemonPort": "8070",
    "filename": "wallet.wallet",
    "password": "",
    "X-API-KEY": ""
}


```
### Install the needed Gems
```gem install excon```


## Examples

## module_example.rb
An example on how it could be used to create other tools.

## check_balance.rb
Checks the balance of the wallet


## create_new_wallet.rb
Create a new wallet

### Creating new wallet
```ruby
puts Wallet.new.create_wallet("new_wallet.wallet", "dogs_cant_look_up")
```

This will create a new wallet. Make sure that any opened wallets are closed.

### Closing wallet
```ruby
puts Wallet.new.wallet_close
```
This will close the wallet so a new one could be opened.

### Setting node
```ruby
puts Wallet.new.set_node("11898",  "TRTLnode.ddns.net")
```
The code above could be used to set a node for the wallet.

### Listing wallet addresses
```ruby
require 'json'
w  = Wallet.new
js = w.list_addresses
JSON.parse(js).each do |key, value|
    puts value
end
```

### More information about a transaction
```ruby
TurtleCoin.transaction_info("kgfhfghfhj")

```

This method will return a bunch of information about a certain transaction. The transaction hash is needed to use this method.

### Get balance of certain addresses
```ruby
puts Wallet.new.balance_address("TRTLuxL46JJaJbTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtzUzedHASfDRYPxVbEiYQsXUtBmQRL18pDdK72F5i")
```

### Create new address
```ruby
puts Wallet.new.create_addresses
```

```ruby
puts Wallet.new.create_addresses(4)

```
The create_addresses method argument controls how many new addresses are created. The create_addresses method will return an array that contains the keys and addresses of the newly created addresses. 

### Get status
```ruby
puts Wallet.new.status
```
Get the wallet sync status, peer count, and hashrate


### transactions unconfirmed
```ruby
puts Wallet.new.transactions_unconfirmed
```


### Transactions
```ruby
puts Wallet.new.transactions
```



### Module_example.rb
The wallet wrapper is just a class that alows us to access the information stored in the wallet by callling a certain method.The module_example uses the methods from the wall wrapper to do certain things. 

A programmer could use the module to list all the users addresses in a certain way. They could create a new method that would the user to save all there created addresses to a file. The sky is the limit

The file module_usage_example.rb includes another example on how the modules could be used to auto start the wallet if it is not already login. The code wil first check the status page to see if the the program is logged in to the wallet. If the program detects that the program is not logged in, it will automally log in to that user that is saved in the wallet config file. Another thing that is it is able to do is to set the node to the defualt address. 

## List all the addresses
```ruby
require_relative 'module_example'
puts TurtleCoin.all_addresses
```

## Get all addresses as an array
```ruby
require_relative 'module_example'
addr = TurtleCoin.get_addresses_array
addr.each do |a|
    puts a
end
```
## Get Balances
```ruby
require_relative 'module_example'
TurtleCoin.get_balances

```
## Get Node Info
```ruby
require_relative 'module_example'
TurtleCoin.node

```

## Create addresses
```ruby
require_relative 'module_example'
p TurtleCoin.create_addresses(5)

```
This will create 5 new addresses. The method will return an array that contains the keys and addresses to the newly created addresses. 

## Transaction Info
Get more information about a certain transactiton.
```ruby
require_relative 'module_example'
puts TurtleCoin.transaction_info(transaction_hash)

```
## Set node
```ruby
TurtleCoin.set_node

```
The method is able to take arguments ( node IP and port). By default the modulei set up to
set the wallet to be synched to `TRTLnode.ddns.net`


### Basic Sinatra Site
All the code that is needed is located in the 'html' directory. 

The first thing that is needed is to install the sinatra gem. This gem makes its a breeze to set up a site. 

The rqrcode gem will be used to create a .svg file that contains a QR code of the address. 
<b>IT IS IMPORTANT TO NOT SHARE THE .SVG file! The QR code contains a Hash of the keys and wallet addresses.</b>

```ruby
gem install sinatra
gem install rqrcode
```
To start the site use the `cd html` command to change the directory to the html directory. This is where all the code is held that will power the site. Next enter the following command:


Make sure that you enter your wallet information in the config.json file in the data directory. 
`ruby run.rb`

This will start the site. Now go to your favorite  web browser and visit:

`http://localhost:4567/`

By default Sinatra uses the port 4567. 
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
