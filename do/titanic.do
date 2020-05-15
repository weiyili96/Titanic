*************************************************************
* name: Titanic
* author: Weiyi Li
* description: casual effect of survival on Titanic and first-class, with some 
*			   other effects
* date: may 14, 2020
*************************************************************

use "/Users/weiyi/Desktop/BU/summer 2020/Titanic/titanic.dta"

* 7b Generate a dummy variable for gender (female=1)
gen gender = 0
replace gender=1 if sex==0

* 7c Generate a dummy if they’re seated in first class
gen first_class = 0
replace first_class=1 if class==1

* 7d 
reg survived first_class
* regress using the robust estimator of variance for heteroskedasticity
regress survived first_class, vce(hc3)

* 7e 
regress survived first_class, vce(cluster sex)

* 7f
* After the decompositon, I think the treu effect of first class on surviiving 
* the sinking is almost the true effect but might be a bit larger, but 
* definitely much better than the non-clustering ones. 

* 7g
regress survived first_class age gender, vce(hc3)
regress survived first_class age gender
** when considering about the heteroskedasticity issue, whether sits in the first
** class and whether is female are positively correlated with survival; age is 
** negatively correlated with survival.
* when not considering about the heteroskedasticity, we got the same result with 
* when considering about the heteroskedasticity, but with different confident 
* intervals. This is because for the heteroskedasticity regression, the formula
* for estimating the standard errors changes when allowing for arbitrary serial 
* correlation within group.

* 7h
mean survived first_class age gender
outreg2 using "/Users/weiyi/Desktop/BU/summer 2020/Titanic/tables/assignment2-7.doc", word append
regress survived first_class age gender, vce(hc3)
outreg2 using "/Users/weiyi/Desktop/BU/summer 2020/Titanic/tables/assignment2-7.doc", word append
regress survived first_class, vce(cluster sex)
outreg2 using "/Users/weiyi/Desktop/BU/summer 2020/Titanic/tables/assignment2-7.doc", word append
regress survived first_class, vce(hc3)
outreg2 using "/Users/weiyi/Desktop/BU/summer 2020/Titanic/tables/assignment2-7.doc", word append

* 8
ssc install reganat, replace
regress survived first_class age gender
regress first_class age gender
* get the residuak of first_class
predict resfirst_class, r
* regress the survival and residual of first_class
regress survived  resfirst_class
* the 2 coefficient are the same, with a little difference on their standard
* errors. I think the coefficients don't vary a lot is because age and gender
* are not highly correlated with each other; therefore, those shouldn't be the 
* disturbance when doing the long regression. 










