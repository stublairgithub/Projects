 library(stringr)
 library(tidyr)
 library(dplyr) 
 
 flight1 = "Flight123"
 flight2 = "Flight456"

 coords1 = "[{23 38 40 43 47 49 50 51 158},7886,0,0.0,-58.35166666666667 -34.82,40.1,174.0,174.0,174.0,0.0,2684.0,,6000,261.0,-58.34789384400509 -34.81630505543276,,176.6,177.2,177.2,,2608.0,,12000,513.0,-58.34403710255359 -34.81252775147768,,180.0,180.9,180.9,,2510.0,,18000,757.0,-58.340126907778725 -34.80869791679936,,180.4,182.1,182.1,,2442.0,,24000,994.0,-58.33619283828932 -34.804844516818285,,180.9,183.3,183.3,,2368.0,,30000,1224.0,-58.33224366232555 -34.800976137287535,,180.6,183.1,183.1,,2314.0,,36000,1450.0,-58.32828238730358 -34.79709572221045,,180.2,183.7,183.7,,2264.0,,42000,1672.0,-58.32429933146058 -34.793193785097166,,182.2,186.2,186.2,,2263.0,,48000,1897.0,-58.32023142182792 -34.789208530007535,,185.7,190.6,190.6,,2292.0,,54000,2125.0,-58.316071533513366 -34.78513296414818,,188.9,194.4,194.4,,2317.0,,60000,2353.0,-58.311842254308395 -34.780989205655075,,191.2,197.5,197.5,,2334.0,,66000,2586.0,-58.307547288600254 -34.77678087395969,,193.5,200.7,200.7,,2352.0,,72000,2820.0,-58.303182993083006 -34.77250438904073,,195.8,203.7,203.7,,2369.0,,78000,3054.0,-58.29875379578259 -34.7681640795289,,198.5,206.9,206.9,,2390.0,,84000,3295.0,-58.29418735534132 -34.763689040015045,,205.9,215.1,215.1,,2466.0,,90000,3543.0,-58.289432532453844 -34.759029128518286,,213.5,224.1,224.1,,2544.0,,96000,3799.0,-58.28448760689135 -34.75418262746912,,219.5,232.9,232.9,,2625.0,,102000,4063.0,-58.279348289118836 -34.74914529924133,,227.6,241.9,241.9,,2703.0,,108000,4333.0,-58.27406525971184 -34.743966788182284,,232.0,246.3,246.3,-50.552213562251566 -26.838254176178523][19,5,0,EnRoute,46482000,ApproachLeg,47100000,FinalApproach,47178000,Landing,47268000,RwyDecelerating,]"

 coords2 = "[{23 38 40 43 47 49 50 51 158},7886,0,0.0,-58.35166666666667 -34.82,40.1,174.0,174.0,174.0,0.0,2684.0,,6000,261.0,-58.34789384400509 -34.81630505543276,,176.6,177.2,177.2,,2608.0,,12000,513.0,-58.34403710255359 -34.81252775147768,,180.0,180.9,180.9,,2510.0,,18000,757.0,-58.340126907778725 -34.80869791679936,,180.4,182.1,182.1,,2442.0,,24000,994.0,-58.33619283828932 -34.804844516818285,,180.9,183.3,183.3,,2368.0,,30000,1224.0,-58.33224366232555 -34.800976137287535,,180.6,183.1,183.1,,2314.0,,36000,1450.0,-58.32828238730358 -34.79709572221045,,180.2,183.7,183.7,,2264.0,,42000,1672.0,-58.32429933146058 -34.793193785097166,,182.2,186.2,186.2,,2263.0,,48000,1897.0,-58.32023142182792 -34.789208530007535,,185.7,190.6,190.6,,2292.0,,54000,2125.0,-58.316071533513366 -34.78513296414818,,188.9,194.4,194.4,,2317.0,,60000,2353.0,-58.311842254308395 -34.780989205655075,,191.2,197.5,197.5,,2334.0,,66000,2586.0,-58.307547288600254 -34.77678087395969,,193.5,200.7,200.7,,2352.0,,72000,2820.0,-58.303182993083006 -34.77250438904073,,195.8,203.7,203.7,,2369.0,,78000,3054.0,-58.29875379578259 -34.7681640795289,,198.5,206.9,206.9,,2390.0,,84000,3295.0,-58.29418735534132 -34.763689040015045,,205.9,215.1,215.1,,2466.0,,90000,3543.0,-58.289432532453844 -34.759029128518286,,213.5,224.1,224.1,,2544.0,,96000,3799.0,-58.28448760689135 -34.75418262746912,,219.5,232.9,232.9,,2625.0,,102000,4063.0,-58.279348289118836 -34.74914529924133,,227.6,241.9,241.9,,2703.0,,108000,4333.0,-58.27406525971184 -34.743966788182284,,232.0,246.3,246.3,-50.552213562251566 -26.838254176178523][19,5,0,EnRoute,46482000,ApproachLeg,47100000,FinalApproach,47178000,Landing,47268000,RwyDecelerating,]"

 df <- data.frame(matrix(ncol = 2, nrow = 0))
 names(df)<-c("flight","coords")

 df1 <- rbind(data.frame("flight" = c(flight1), "coords"=c(coords1)))
 df2 <- rbind(data.frame("flight" = c(flight2), "coords"=c(coords2)))

 df <- rbind(df,df1)
 df <- rbind(df,df2)

suppressWarnings(df <- separate(data = df, col = coords, into = c("coords", "ignore"), sep = "\\]"))

df = data.frame(df$flight, df$coords)
names(df)<-c("flight","coords")

flightpath <- data.frame(matrix(ncol = 2, nrow = 0))
names(flightpath)<-c("flight","coords")

for(i in 1:nrow(df)) {
          tempdf <- df[i,]
          # do stuff with tempdf
          coords = strsplit(as.character(tempdf$coords), ",")
          t <- c(do.call("cbind",coords)) 
          s<-t[seq(5,length(t),10)]
          df2 = data.frame(tempdf$flight, cbind(s))
          names(df2)<-c("flight","coords")

          flightpath <- rbind(flightpath,df2)
          }

flightpath <- separate(data = flightpath, col = coords, into = c("lon", "lat"), sep = "\\ ")
flightpath$lon = as.numeric(as.character(flightpath$lon))
flightpath$lat = as.numeric(as.character(flightpath$lat))