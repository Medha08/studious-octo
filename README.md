# studious-octo

LinkedList EVM Package

Including all installations(Ganache,zos(I installed locally),truffle v5)

```
  >npm init
  >npm install zos (to install zepplin OS)
  >npx zos init LinkedList (to track the details of your ZeppelinOS project & initialize truffle project)
  >npm install truffle@5.0.4
```

# Files after the above steps

1. package.json (created by npm init )
2. Two empty directories named contracts and migrations (created by zos for Truffle)
3. A zos.json file (created by zos for ZeppelinOS).

# Steps to follow

1. Modify the sol file
2. zos-lib is not installed by default but we’re importing from the zos-lib a contract called Initializable.sol
3. Initialize(), which uses the library modifier initializer, which can be found in the zos-lib/contract/Initializable.sol contract.
4. Install the package npm install zos-lib
5. Deploy the contract ganache-cli --port 9545 --deterministic
6. Deterministic flag allows to run ganache with same addresses for easy development and cto use custom mnemonic `ganache-cli --port 9545 --deterministic –mnemonic "twelve word mnemonic here"`

7. Create a new session for ZeppelinOS `npx zos session --network local --from 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1 --expires 3600`

8. Specified address is the one from which ZeppelinOS will be deploying contracts and managing them ie it is the address which will never be used other than upgrading the contract which means it will not be used to interact with the contract

9. When a request or contract call is made from an address, it is checked whether address is the deployment address or not if it is deployment address then it is allowed to manage the Proxy contract and if it is not the deployment address then the contract call is forwarded to logic contract.

# A Short Break to Revise what we did so far

1. Set up your ZeppelinOS session
2. Created your contract
3. Have development blockchain running

We need to add the contract to Zeppelin OS Project

# Continue

## Add Contract

1. Add Contract `npx zos add LinkedList`
2. If We look at the zos.json file, we will see that our JSON object now contains our contract “LinkedList” under the “contracts” key value.
3. We now have a top-level folder in our project named build that contains a subfolder called contracts, which is where the JSON objects representing the contract’s ABI
4. Now that We have added our LinkedList.sol contract to the ZeppelinOS project, we can deploy the project to the development blockchain

## Deploy Contract

1. Deploy Contract/Contracts `npx zos push`
2. When it comes time to deploy to a different network (such as a public test-net or mainnet), we will run the zos session command again with a new network, as defined in our truffle-config.js file. We can also add the --network flag followed by our network name if we want to push without starting a session.
3. Created zos.dev-<<some number here>>.json
4. The “<<some number here>>” will be the network-id of your development blockchain. This will most likely be a pseudo-random number when working with a development chain and is used just to identify the network

## Create Instance of our Contract

1. Now that we have deployed our project, we need to make an instance of our contract to interact with it.
2. `npx zos create LinkedList --init initialize --args Sample LinkedList`
3. This command creates an instance of our LinkedList.sol and calls the initialize function in place of what would normally have been a constructor.
4. It will return an address where the instance was created (these addresses will be unique to your project):
5. The zos create command creates an instance of the contract on the blockchain that we can directly interact with.
6. While zos push deploys the project, our project isn’t intended to be directly manipulated.
7. ZeppelinOS gives us the ability to create proxies of contracts that point to the original contracts we wrote
8. This gives us the ability to upgrade our contracts by telling ZeppelinOS we want to point our instance of a contract to a newer version of our original contract.
9. zos.dev-<<some number here>>.json has “proxies” near the bottom of the file,this is where ZeppelinOS keeps track of your contract deployments on this particular network
10. The address refers to the location of the proxy of your contract, version is the version of our instance, and implementation points to the logic contract our contract calls will be proxied to.
11. The address entry will be the address that you will use when you want to connect to your contract (via the proxy) for something like testing or via web3 in a dApp

## Testing and Publishing

1. Directly test the network in truffle console `npx truffle console --network local`
2. Create an instance of contract `<your-contract-address>')`

### Testing

      1. `myLinkedList.head() -> '0x0000000000000000000000000000000000000000000000000000000000000000' `
          There is no head yet, so this is the expected output
      2. `myLinkedList.addNode("Hello World!") `
          This should return a transaction object and logs and see reflected transaction in ganache
      3. `myLinkedList.head()`
          Our new head's byte32 id ie the location of head node (we can get the node by nodes mapping by passing the id argument of that node)
      4. `myLinkedList.nodes('< above id >')`
          This returns the struct node in form of array of node values(next and data),next will be 0x00..
      5. `myLinkedList.popNode()`
          This pops off the head from list and returns the transaction
      6.  `myLinkedList.head() -> '0x0000000000000000000000000000000000000000000000000000000000000000' `
