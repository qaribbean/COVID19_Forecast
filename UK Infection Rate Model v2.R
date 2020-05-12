# No specific R packages required, base packages are enough.

# load data into a data frame called "dataset"
dataset = read.csv("UK Infection Data v2")

# The number of people having died from COVID-19 is much more reliable than the number of infections.
# Our best estimate of the true fatality rate of COVID-19 in the UK is 0.9% of the number of infected persons
# Infection Fatality Rate (IFR) estimates were based on Verity et al. and adjusted for a non-uniform attack rate 
# to give an IFR of 0.9% (95% credible interval 0.4%-1.4%).
# we know that the time from reporting of an infection to death is about 10 days.

n = length(dataset$Confirmed_Cases)

# Function of prediction
shift = function(x, n = 10){
  c(x[-(seq(n))], rep(NA, n))
}

# UK Infection Fatality Rate currently estimated at 0.9% (https://www.cebm.net/covid-19/global-covid-19-case-fatality-rates/)
# Using this we can then estimate the daily infection rate
dataset$estimated_true_infections = shift(round(dataset$Total_Deaths / 0.009))

# Confirmed cases as a percentage of our estimated true infections
dataset$perc_true_infections = round(dataset$Confirmed_Cases / dataset$estimated_true_infections, 4)

# What do we estimate the daily true infection rate to be over the next 10 days?
(real_daily_inf = round(tail(dataset$Confirmed_Cases, 10) / mean(dataset$perc_true_infections[(n-12):(n-10)])))

# What do we estimate the daily number of deaths to be over the next 10 days?
(round(real_daily_inf * 0.009))


