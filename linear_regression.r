# Day 1 - Load built-in dataset
data(mtcars) ## mtcars is a built-in dataset in R
head(mtcars) ## this shows the first 6 rows of the dataset

# to see a summary of each column (min, median, mean, max)
summary(mtcars) ## this shows summary statistics for each column

# to see relationships between columns
cor(mtcars$mpg, mtcars$wt) ## to see how mpg relates/reacts to weight
cor(mtcars$mpg, mtcars$hp) ## to see how mpg relates/reacts to horsepower

# to visualize a relationship
plot (mtcars$wt, mtcars$mpg
      ,main = "MPG vs Weight"
      ,xlab = "Weight (1000 lbs)"
      ,ylab = "Miles per Gallon"
      ,pch = 19
      ,col= "steelblue")

# Fit the linear regression model
model <- lm(mpg ~ wt, data = mtcars) ## mpg is dependent variable, wt is independent variable
  ### dependent variable (response) is what you are trying to predict/explain
  ### independent variable (predictor) is what you are using to predict/explain
  ## mpg is first because, we are evaluating how it reacts to weight
  
  ## the output of this model will give us an intercept and slope
  ## The model equation will be: mpg = intercept + slope * wt

# View the summary of the model
summary(model)

# Results:
# Residuals:
#     Min      1Q  Median      3Q     Max
# -4.5432 -2.3647 -0.1252  1.4096  6.8727

# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)
# (Intercept)  37.2851     1.8776  19.858  < 2e-16 ***
# wt           -5.3445     0.5591  -9.559 1.29e-10 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Residual standard error: 3.046 on 30 degrees of freedom
# Multiple R-squared:  0.7528,    Adjusted R-squared:  0.7446
# F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10

## The intercept (37.29) is the predicted mpg when weight (wt) = 0 (not realistic here, but part of the equation).
## The slope (−5.34) means: for each additional 1000 lbs of weight, mpg decreases by about 5.34.


##The negative slope (−5.34) isn't just noise — it's likely a real effect

##You’re not just seeing a random pattern in the data

##🧠 Rule of Thumb (for p-values)
##p-value	Meaning
##< 0.001	✅ Very strong evidence (*** in output)
##< 0.01	✅ Strong evidence (** in output)
##< 0.05	✅ Acceptable evidence (* in output)
##> 0.05	❌ Not statistically significant

##This means:
  
  ##R-squared = 0.75 → 75% of the variation in MPG can be explained by car weight.

##The remaining 25% is due to other factors not in the model (e.g., horsepower, engine size, aerodynamics, etc.)

##✅ Rules of Thumb (Context Matters)
##R-squared Value	Interpretation
##0.90 – 1.00	Excellent fit (very rare in real-world data)
##0.70 – 0.89	Good fit — your model explains most variation
##0.40 – 0.69	Moderate — might be useful, but other variables missing
##< 0.40	Weak model — probably needs more predictors

##🔍 In social sciences, 0.3–0.5 might still be valuable. In manufacturing or physics, you often want 0.8+.

##💡 In your case:
  ##If R² = 0.75, that's strong: weight is a strong predictor of mpg, but not the only one.

##It tells your stakeholders: “We can explain ~75% of mpg variation using just weight.”


# Basic residual plot
plot(model$residuals,
     main = "Residuals from Linear Model",
     ylab = "Residuals (Error)",
     xlab = "Index",
     pch = 19,
     col = "darkorange")

abline(h = 0, lty = 2, col = "gray")
## a residual plot helps diagnose if linear regression assumptions hold:
  ## Linearity: Residuals should be randomly scattered around 0
  ## Homoscedasticity: Spread of residuals should be roughly equal across all fitted values
  ## No patterns: No curves, funnels, or clusters in residuals
# -------------------------------------------------------------
# 📊 Residual Plot Interpretation Guide (Reference Notes)
# -------------------------------------------------------------

# ✅ What Residuals Should Look Like:
# • Randomly scattered around 0
# • No clear pattern, shape, or trend
# • Roughly equal spread (homoscedasticity)

# 🚩 Common Residual Patterns and What They Mean:

# 1. Curve Shape:
# - Meaning: Non-linear relationship not captured by linear model
# - Fix: Try polynomial regression (e.g., add I(x^2)) or use non-linear models

# 2. Funnel Shape (widening or narrowing spread):
# - Meaning: Heteroscedasticity (changing variance)
# - Fix: Log or sqrt transform the dependent variable (e.g., log(y)), or use WLS

# 3. Big Outliers:
# - Meaning: Individual points are influencing the model too much
# - Fix: Investigate data, use robust regression (e.g., MASS::rlm), or exclude outliers

# 4. Clear Groups or Stripes:
# - Meaning: Missing a categorical variable or subgroup structure
# - Fix: Add categorical variables (e.g., factor(type)), or model groups separately

# 🧪 Bonus Diagnostic Plots in R:
# - Residuals vs Fitted: plot(model)
# - Q-Q Plot: qqnorm(resid(model)); qqline(resid(model))
# - Influence Plot: car::influencePlot(model)


#Goal: Model mpg as a function of wt using simple linear regression.

#Key findings: Slope was negative (heavier cars → lower mpg). R² ≈ ____ (explain what % of variance weight explains).

#Significance: p‑value for wt < 0.05, so relationship is statistically significant. 
## this means we can be confident that weight truly affects mpg, not just random chance.
## the p-value is calculated based on the t-statistic for the slope coefficient, testing the null hypothesis that slope = 0 (no effect).

#Diagnostics: Residuals centered around 0 with no strong pattern → linearity/constant variance looked ok.
## had a wave pattern, which may suggest a non-linear relationship that linear model didn't fully capture.

#Limitations: Single predictor; likely missing factors (hp, cylinders, etc.).

#Next step: Try mpg ~ wt + hp and/or polynomial term I(wt^2); compare R² and residuals.


# -------------------------------------------------------------
# 📓 Week 1 Reflection – Linear Regression (Learning Summary)
# -------------------------------------------------------------
# This week I learned how to approach and interpret a simple linear regression model
# in R using the mtcars dataset, focusing on mpg (dependent variable) and weight (independent variable).
#
# 1️⃣ Data exploration
# - Used summary() to see min, median, mean, and max for each variable.
# - Used cor() to measure relationships: mpg has a strong negative correlation with weight and horsepower.
# - Visualized mpg vs weight with a scatter plot, learning how pch and col control point style and color.
#
# 2️⃣ Model creation
# - Fitting the model with lm(mpg ~ wt) taught me that the dependent variable (mpg) goes first
#   because we are modeling how it reacts to the independent variable (weight).
# - The model output showed an intercept and slope, which form the equation to predict mpg from weight.
#
# 3️⃣ Statistical significance
# - A predictor is statistically significant if its p-value is < 0.05, meaning the observed effect
#   is unlikely to have happened by chance.
# - In this model, weight’s slope was negative and highly significant (p-value ≪ 0.001),
#   indicating a real and strong relationship: heavier cars tend to get lower mpg.
#
# 4️⃣ R-squared interpretation
# - R² = 0.75 means 75% of the variation in mpg can be explained by weight alone.
# - The remaining 25% comes from other variables not in the model (e.g., horsepower, engine size, aerodynamics).
# - Good practice: In manufacturing/physics, aim for R² ≥ 0.8; in social sciences, 0.3–0.5 can still be valuable.
#
# 5️⃣ Residual plots
# - Residuals are the differences between actual and predicted values.
# What is the difference between residuals and errors in regression analysis?
# - A well-behaved residual plot shows points scattered randomly around 0 with no pattern.
# - Learned to diagnose patterns:
#   • Curve shape → add polynomial terms or use non-linear models
#   • Funnel shape → variance changes, consider log/sqrt transforms or weighted regression
#   • Outliers → investigate or use robust regression
#   • Clusters → missing categorical variable
#
# 6️⃣ Key takeaway
# - Linear regression is not just drawing a line — it’s building a predictive model backed by statistics.
# - Understanding p-values, R², and residual behavior helps confirm whether the model is valid,
#   and informs when to try transformations, add predictors, or switch modeling approaches.
# When to use linear regression versus other modeling techniques?
# # Linear regression is best for continuous dependent variables with linear relationships to predictors.
# -------------------------------------------------------------
