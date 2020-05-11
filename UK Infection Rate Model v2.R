
setwd('H:/COVID19/')
dataset = read.csv("UK Infection Data v2")
n = length(dataset$Confirmed_Cases)

# Function of prediction
shift = function(x, n = 10){
  c(x[-(seq(n))], rep(NA, n))
}

# UK Infection Fatality Rate currently estimated at 0.9% (https://www.cebm.net/covid-19/global-covid-19-case-fatality-rates/)
dataset$estimated_true_infections = shift(round(dataset$Total_Deaths / 0.009))

dataset$perc_true_infections = round(dataset$Confirmed_Cases / dataset$estimated_true_infections, 4)

# What do we estimate the daily true infection rate to be over the next 10 days?
(real_daily_inf = round(tail(dataset$Confirmed_Cases, 10) / mean(dataset$perc_true_infections[(n-12):(n-10)])))

# What do we estimate the daily number of deaths to be over the next 10 days?
(round(real_daily_inf * 0.009))


