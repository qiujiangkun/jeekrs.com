---
title: WP-ReliableMD测试效果
date: 2018-10-05 16:19:33
---
# 本站切换了自己写的`WP-ReliableMD`插件，现测试效果
 ![image](https://cloud.githubusercontent.com/assets/389021/16107646/9729e556-33d8-11e6-933f-5b09fa3a53bb.png)
 $E=mc^2$ linline math
 $f(x)=x^2$
 block math
 ```latex
 e^{i\pi}+1=0
 ```
# GFM Markdown
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
    code block
```js
console.log("fenced code block");
```
<pre>**HTML block**</pre>
* list
    * list indented
1. ordered
2. list
    1. ordered list
    2. indented

- [ ] task
- [x] list completed

[link](https://nhnent.github.io/tui.editor/)
> block quote
---
horizontal line
***
`code`, *italic*, **bold**, ~~strikethrough~~, <span style="color:#e11d21">Red color</span>

# Table Cell Merge

| @cols=2:merged |
| --- | --- |
| table | table |

# Charts

```chart
,Budget,Income,Expenses,Debt
June,5000,8000,4000,6000
July,3000,1000,4000,3000
Aug,5000,7000,6000,3000
Sep,7000,2000,3000,1000
Oct,6000,5000,4000,2000
Nov,4000,3000,5000,4000

type: column
title: Monthly Revenue
width: 465
x.title: Amount
y.title: Month
y.suffix: $
legend.visible: false
```

# UML

```uml
class BaseClass

namespace net.dummy #DDDDDD {
    .BaseClass <|-- Person
    Meeting o-- Person

    .BaseClass <|- Meeting
}

namespace net.foo {
  net.dummy.Person  <|- Person
    .BaseClass <|-- Person

  net.dummy.Meeting o-- Person
}

BaseClass <|-- net.unused.Person
```
