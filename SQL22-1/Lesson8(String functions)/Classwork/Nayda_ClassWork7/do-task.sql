select [CardType],
       substring([CardNumber],5,4), 
    count ( substring([CardNumber],5,4))
 from [Sales].[CreditCard]
 Group by [CardType], substring([CardNumber],5,4)
 having  Count ( substring([CardNumber],5,4)) > 1
 Order by CardType asc