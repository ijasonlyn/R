<div style="font-size:30px;font-weight:bold;text-align:center;">远期外汇、期货会计处理及披露<br> <span style="font-size:25px;color:gray">--- 讨论稿，待与审计确认</span></div>

# 背景说明

## 远期售汇

与银行签订远期售汇协议，锁定汇率，规避美元汇率下跌。公司的应收很大一部分是以美元收回，但支出几乎全部都是以人民币结算。

## 买多(long)镍期货

通过证券公司购买镍期货，镍为公司原材料，目的是锁定价格，规避镍现货价格上升的风险。

# 我司的远期售汇及镍期货合约为现金流量套期

根据参考文件（I.36）和（I.64.a），以上两项适用参考文件 （II），即这两项业务属于套期会计准则的使用范围。

同时，依据（II），我司购买这两项金融合约是出于对后期价格的不利变动对我司的预期现金流产生影响。外汇是出于美元持续下跌造成用于支付的人民币（记账本位币）减少；镍期货是出于原材持续上涨，公司将面临支付增加。

这两项金融产品满足（II.15）所列的三个条件：

1. 套期工具（远期售汇、镍期货）与被套期项目（外币收入，镍购买）；
2. 指定见1；风险管理已公告（详见公告）；
3. 这两项金融产品的规模严格控制在预期外币收入及镍使用量的范围之内。

同时也满足（II.16）的要求。

# 会计科目设置(III.5 and III.6)

## 依据 III.5，设置5个科目

- “套期工具 hedging instrument” （BS）
- “套期损益 hedging g/l” （PL）： Gain or Loss of <u>*hedging instrument and hedged item*</u> **under fair value hedge**.
- "被套期项目 Hedged Item" (BS):  Asset or liability arreared by the $\Delta FV$ and the value of *hedged item*  **under fair value hedge**
- "净敞口套期损益 Net exposure to hedging g/l"(PL) : 净敞口套期下 *被套期*  项目 *累计公允价值变动* 转入当期损益的金额；
- OCI (BS): effectiveness portion of accumulative $\Delta FV$ **under cash flow hedge**

## III.6 Accounting

Note: comparing to FVH, NO "Hedged Item" account is used under CFH.

|                                      | 公允价值套期(PL)                                             | 现金流量套期(OCI)                                            |
| ------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 指定套期关系<br>（目前不适用于公司） | Dr[^3]  Hedged Item(BS) <br>Dr provision for obsolete stock(BS)<br>     Cr Raw material / Finished goods(BS)    @book value | N/A                                                          |
| 存续期间                             | 1. recog g/l <br><br>Dr/Cr Hedging instrument(BS)      @gain or loss <br>    DR/Cr Hedging g/l (PL) <br><br>2. recog $\Delta FV$<br><br>Dr/Cr Hedged Item(BS)   @ $\Delta FV$ <br>    Dr/Cr Hedging g/l | Dr/Cr Hedging Instrument(BS)   @gain or loss  <br> Dr/Cr  OCI (BS)    @effectiveness portion[^4]<br> Dr/Cr g/l on $\Delta FV$(PL)   @ineffective portion |
| 套期关系终止                         | Dr/Cr Hedged Item(BS)<br>   Dr/Cr Inventory or COGS or Revenue[^5]<br><br>settlement of hedging instrument<br><br>Dr/Cr  Other receivable/cash<br>   Cr/Dr Hedging instrument | Clearing OCI (by Dr/Cr  OCI) , if:<br>- not expected any more:  Dr/Cr g/l on $\Delta FV$(PL)<br/>- become comitment:  omitted<br/><br>settlement of hedging instrument<br/><br/>Dr/Cr  Other receivable/cash<br/>   Cr/Dr Hedging instrument |
| 后续处理                             | If hedged Item is (by dr/cr hedged item)<br>- for **stock**:  when sold, go to COGS;<br>- for **purchase commitment**:  to inventory<br>- for **sale commitment**:  to Revenue<br>- for **net exposure**: to *Net exposure to hedging g/l* | If hedged Item is (by dr/cr OCI)<br>- for **expected purchase**: to inventory <br>- for **expected sale**: to revenue<br>- converted to Commitment and designed as FVH: to hedged item |

## Presentation and disclosure

### B/S

- Hedging instrument: 

  if balance in debit, go to **asset of FV2PL** , if in credit, go to **liability of FV2PL**

- Hedged Item: 

  If inventory, inventory, if commitment, other current asset/liability or other non-current asset/liability.

### P/L

- Hedging gain/loss: 

  g/l on $\Delta FV$

- Ineffective portion (not applicable, omitted)

- Net exposure (not applicable, omitted)

### Disclosure (omitted)

# 操作

? 由于被套期项目均不属于以公允价值计量且其变动计入当期损益的金融资产（FV2PL）[^1]；



## 现金流量套期

### 初始确认

Dr/Cr	套期工具---外汇远期合同（或期货合同）

​		Cr/Dr 	其他综合收益(OCI) --- 套期储备

### 持续计量，分录同初始确认

### 终止

#### 结清套期工具的会计科目

Dr/Cr	银行存款（或保证金账户）等

​		Cr/Dr	套期工具---外汇远期合同（或期货合同）

#### 结清其他综合收益(CI)

Dr/Cr		OCI

​		Cr/Dr	公允价值变动损益( g/l on $\Delta FV$(PL) )



# 参考文件

I. 《企业会计准则第22号 ------ 金融工具确认和计量》

II. 《企业会计准则第24号 ------ 套期会计》

III.[《商品期货套期业务会计处理暂行规定》](http://kjs.mof.gov.cn/zhengcejiedu/201512/t20151214_1613270.htm)

[^1]: 外币资产，如外币存款、外币应收（外币应付可完全忽略）均按月末汇率折算，这部分是否属于FV2PL?
[^2]: 这里建议用主营业务成本是出于镍合约不大，一个月的量，且合约同时是两个月以上的。

[^3]: 指将存货指定为被套期项目
[^4]: min(Accumulated gain or loss from HEDGING INSTRUMENT ,   accumulated $\Delta$PV of CF)  - OCI's book value
[^5]: If the commitment is for purchase, then choose inventory account, if for sale, then revenue.
