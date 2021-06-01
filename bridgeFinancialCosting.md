<p style="font-size:30px;text-align:center;font-weight:bold">会计与产值差异</p>


$$
\begin{align}
a &:= actual \\
b &:= benchmark \\
+ &:= stock \ in \\
- &:= used \ or\ charge\ out \\
h &:= manufacturing \  overhead \\
g &:= SGA \\
\sigma &:= variance \ or\ under \ over \ absorption \\
\tau &:= total\ product\ cost\ i.e.\ m + l + h
\end{align}
$$

# FROM MLH to shipout



```mermaid
graph TD

M- --> |period x| OUTPUT
L- --> |period x| OUTPUT
H- --> |period x| OUTPUT
OUTPUT --> |period x| INVENTORY
INVENTORY --> |period x or y|COGS
```





| Financial costing                                            | Variable costing                                             | Quasi-cash                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Revenue：$q^ap^a$                                            | $q^ap^a$                                                     | $q^{+a}p^a$                                                  |
| - benchmark cost[^1]： <br>$$\begin{align} &(m^b + l^b + h^b) \times q^a \end{align}$$ | $$\begin{align} &(m^b + l^b) \times q^a \end{align}$$        | $$M^- + L^- + H^-$$                                          |
| - cost variance：<br>$$\begin{align} &\tau^{\sigma} \times q^a  \end{align}$$ <br> may not break dwon to mlh | $$\begin{align} &M^{\sigma} \\ &L^{\sigma}  \end{align}$$ <br><span style="font-size=6">assuming m, l is variable</span> | The variance may come <br>from different period, and <br>different product mix |
| = Gross Margin：                                             | = CM^gross^                                                  |                                                              |
|                                                              | - h^v^                                                       |                                                              |
|                                                              | - g^v^                                                       |                                                              |
|                                                              | = CM                                                         |                                                              |
| - SGA: g                                                     | -FC: (h^f^ + g^f^ )                                          | -g                                                           |
| = EBIT^accounting^:                                          | = EBIT^variableCosting^:                                     | = EBIT^quasi-cash^:                                          |
|                                                              |                                                              |                                                              |

$$
\begin{align}
M^- &= \sum_i (m_i^b \pm m_i^\sigma ) q_i^{+a} \\
M^{\sigma} &= \sum_i m_i^{\sigma} q_i^{+a}
\end{align}
$$



[^1]: This may be further broken down to target cost and engineer cost.

