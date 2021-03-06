# coinflip_smart-contract

#### A simple coin-flip betting game so you can lose money to your friends *on the blockchain*

## Features
* commit-reveal scheme for generating randomness
  1. Both players ante a sum of ETH and select a nonce value as their random input. They submit a hash of the nonce with their ante in order to conceal the value of the nonce.
  2. Both players submit the un-hashed nonce value. The value of each nonce is verified by hashing it and comparing to the hash submitted with the ante.
  3. Player 1 wins if the sum of the two nonces is even. Player 2 wins if the sum of the two nonces is odd.
  4. If a player has not submitted an input after a set time, the other player is entitled to withdraw all of the ETH from the contract.

## Possible attacks for this type of contract
* Psudo-randomness
  * A player manipulates the source of randomness, or uses knowledge of imperfect randomness to improve odds of winning. This is likely only financially viable if playing for large sums of money.
  * Solution: double commit-reveal scheme provides off-chain randomness generated by both parties.
* Front-running
  * Player 2 waits to see a call submitted by player 1 and then uses a high block reward or control of mining power to submit a call which is processed first.  
  * Solution: require a different nonce value from Player 2. This ensures Player 2 cannot observe Player 2's submission and front-run with a submission of the the same value in order to guarantee an even result.
