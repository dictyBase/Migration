# Cloud hosting
## Amazon EC2
### Projected costs
__Staging:__ 3243.44$/year

__Production:__ 6486.88$/year

__Total:__ 9730.32$/year

#### Possible growth points
These are the places which might increase the costs.
* Increase data transfer or dictyBase has more users or it is getting more hits etc.
* Increase storage requirements, for example, users are doing more NGS and we started to get more datasets.
* Adding more VMs that might be a side effect of getting more data transfer.

However, at this point these growth are hard to measure and so do their associated costs.

### Facts about cost calculation
+ The basic breakdown for __staging__ is [here](http://calculator.s3.amazonaws.com/index.html#r=IAD&s=EC2&key=calc-B1A81899-BEF5-46A6-BAA5-CD249B0A80D0)
+ The projection for __production__ is done by doubling the cost of __staging__
+ Excludes intermine/dictyMine backend, at this point not sure whether it would
  fit in the existing database or will need another extra machine for that.
+ The cost of data transfer should not vary too much, currently for 20GB/month, it costs 1.71$/month.
+ Storage requirements is expected to increase, however at this point it is hard to predict the growth.
+ The server [architecture](http://testgenomes.dictybase.org/server.slide),
  particularly look at [this](http://testgenomes.dictybase.org/server.slide#4) and
  [this](http://testgenomes.dictybase.org/server.slide#5) slides for various
  VMs that we need.


