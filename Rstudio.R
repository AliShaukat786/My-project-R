
R version 4.2.3 (2023-03-15 ucrt) -- "Shortstop Beagle"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/.RData]

> df<- read.csv('https://public.tableau.com/app/sample-data/HollywoodsMostProfitableStories.csv')
> 
  > View(df)
> 
  > install.packages("tidyverse")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
  
  https://cran.rstudio.com/bin/windows/Rtools/
  Installing package into ‘C:/Users/alish/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/tidyverse_2.0.0.zip'
Content type 'application/zip' length 430823 bytes (420 KB)
downloaded 420 KB

package ‘tidyverse’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\alish\AppData\Local\Temp\Rtmp25mYjs\downloaded_packages
> 
  > str(df)
'data.frame':	74 obs. of  8 variables:
  $ Film             : chr  "27 Dresses" "(500) Days of Summer" "A Dangerous Method" "A Serious Man" ...
$ Genre            : chr  "Comedy" "Comedy" "Drama" "Drama" ...
$ Lead.Studio      : chr  "Fox" "Fox" "Independent" "Universal" ...
$ Audience..score..: int  71 81 89 64 84 80 66 80 51 52 ...
$ Profitability    : num  5.344 8.096 0.449 4.383 0.653 ...
$ Rotten.Tomatoes..: int  40 87 79 89 54 84 29 93 40 26 ...
$ Worldwide.Gross  : num  160.31 60.72 8.97 30.68 29.37 ...
$ Year             : int  2008 2009 2011 2009 2007 2011 2010 2007 2008 2008 ...
> 
  > colSums(is.na(df))
Film             Genre       Lead.Studio Audience..score..     Profitability 
0                 0                 0                 1                 3 
Rotten.Tomatoes..   Worldwide.Gross              Year 
1                 0                 0 
> 
  > df <- na.omit(df)
> 
  > colSums(is.na(df))
Film             Genre       Lead.Studio Audience..score..     Profitability 
0                 0                 0                 0                 0 
Rotten.Tomatoes..   Worldwide.Gross              Year 
0                 0                 0 
> 
  > dim(df[duplicated(df$Film),])[1]
[1] 0
> 
  > df$Profitability <- round(df$Profitability ,digit=2)
> df$Worldwide.Gross <- round(df$Worldwide.Gross ,digit=2)
> 
  > dim(df)
[1] 70  8
> 
  > library(ggplot2)
> 
  > ggplot(df,aes(x=Profitability, y=Worldwide.Gross))+geom_boxplot(outlier.colour= "red",outlier.shape= 1)+scale_x_continuous(labels = scales::comma)+coord_cartesian(ylim= c(0,1000))
Warning message:
  Continuous x aesthetic
ℹ did you forget `aes(group = ...)`? 
  > ggplot(df, aes(x=Profitability, y=Worldwide.Gross))+geom_boxplot(outlier.colour= "red",outlier.shape= 1)+scale_x_continuous(labels = scales::comma)+coord_cartesian(ylim= c(0,1000))
Warning message:
  Continuous x aesthetic
ℹ did you forget `aes(group = ...)`? 
  > Q1 <- quantile(df$Profitability, .25)
> 
  > Q3 <- quantile(df$Profitability, .75)
> 
  > IQR <- IQR(df$Profitability)
> 
  > no_outliers <- subset(df, df$Profitability> (Q1 - 1.5*IQR) & df$Profitability< (Q3 + 1.5*IQR))
> 
  > dim(no_outliers)
[1] 65  8
> 
  > Q1 <- quantile(no_outliers$Worldwide.Gross, .25)
> 
  > Q3 <- quantile(no_outliers$Worldwide.Gross, .75)
> 
  > IQR <- IQR(no_outliers$Worldwide.Gross)
> 
  > df1 <- subset(no_outliers, no_outliers$Worldwide.Gross> (Q1 - 1.5*IQR) & no_outliers$Worldwide.Gross< (Q3 + 1.5*IQR))
> 
  > dim(df1) 
[1] 61  8
> 
  > summary(df1)
Film              Genre           Lead.Studio        Audience..score.. Profitability  
Length:61          Length:61          Length:61          Min.   :35.00     Min.   :0.000  
Class :character   Class :character   Class :character   1st Qu.:52.00     1st Qu.:1.750  
Mode  :character   Mode  :character   Mode  :character   Median :62.00     Median :2.530  
Mean   :63.02     Mean   :3.014  
3rd Qu.:72.00     3rd Qu.:3.750  
Max.   :89.00     Max.   :8.740  
Rotten.Tomatoes.. Worldwide.Gross       Year     
Min.   : 3.0      Min.   :  0.03   Min.   :2007  
1st Qu.:27.0      1st Qu.: 32.40   1st Qu.:2008  
Median :43.0      Median : 69.31   Median :2009  
Mean   :46.7      Mean   :103.16   Mean   :2009  
3rd Qu.:64.0      3rd Qu.:153.09   3rd Qu.:2010  
Max.   :93.0      Max.   :355.08   Max.   :2011  
> 
  > ggplot(df1, aes(x=Lead.Studio, y=Rotten.Tomatoes..)) + geom_point()+ scale_y_continuous(labels = scales::comma)+coord_cartesian(ylim = c(0, 110))+theme(axis.text.x = element_text(angle = 90))
> 
  > ggplot(df1, aes(x=Year)) + geom_bar())
Error: unexpected ')' in "ggplot(df1, aes(x=Year)) + geom_bar())"
> ggplot(df1,aes(x=Year)+geom_bar())
Error in `ggplot()`:
  ! `mapping` should be created with `aes()`.
✖ You've supplied a <NULL> object
Run `rlang::last_trace()` to see where the error occurred.
> rlang::last_trace()
<error/rlang_error>
Error in `ggplot()`:
! `mapping` should be created with `aes()`.
✖ You've supplied a <NULL> object
---
  Backtrace:
  ▆
1. ├─ggplot2::ggplot(df1, aes(x = Year) + geom_bar())
2. └─ggplot2:::ggplot.default(df1, aes(x = Year) + geom_bar())
Run rlang::last_trace(drop = FALSE) to see 2 hidden frames.
> rlang::last_trace(drop = FALSE)
<error/rlang_error>
  Error in `ggplot()`:
  ! `mapping` should be created with `aes()`.
✖ You've supplied a <NULL> object
---
Backtrace:
    ▆
 1. ├─ggplot2::ggplot(df1, aes(x = Year) + geom_bar())
 2. └─ggplot2:::ggplot.default(df1, aes(x = Year) + geom_bar())
 3.   └─cli::cli_abort(...)
 4.     └─rlang::abort(...)
> ggplot(df1, aes(x=Year)) +geom_bar())
Error: unexpected ')' in "ggplot(df1, aes(x=Year)) +geom_bar())"
> ggplot(df1,aes(x=Year))+geom_bar())
Error: unexpected ')' in "ggplot(df1,aes(x=Year))+geom_bar())"
> ggplot1::ggplot(df1, aes(x = Year) + geom_bar())
Error in loadNamespace(x) : there is no package called ‘ggplot1’
> ggplot2::ggplot(df1, aes(x = Year) + geom_bar())
Error in `ggplot2::ggplot()`:
! `mapping` should be created with `aes()`.
✖ You've supplied a <NULL> object
Run `rlang::last_trace()` to see where the error occurred.
> ggplot(df1, aes(x=Year)) + geom_bar()