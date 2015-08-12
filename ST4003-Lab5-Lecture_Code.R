# Section 2.1
i = rnorm(1)
i
if(i > 0.25) {
    cat("i is greater than a quarter")
} else {
    cat("i is less than or equal to a quarter")
}



i = rnorm(1)
i
if(i > 0) {
    cat("Heads")
} else {
    cat("Tails")
}



# Section 2.2
total = 0
upto = 10
for(j in 1:upto) {
    total = total + log(j)
    cat("The natural log of", j, "is", log(j), "\n")
}
cat("The sum of the natural logs of 1 to", upto, "is", total)



total = 0
for(j in 1:100) {
	i = rnorm(1)
	if(i > 0) {
		total = total+1
	}
}
total



# Section 2.3
drawCards = function(number) {
    faceValues = c(1:10, "Jack", "Queen", "King")
    suits = c("Hearts", "Diamonds", "Spades", "Clubs")
    f = sample(faceValues, number, replace=TRUE)
    s = sample(suits, number, replace=TRUE)
    paste(f, "of", s)
}

drawCards(5)



tossCoin = function(number=200) {
	total=0
	for(j in 1:number) {
		i = rnorm(1)
		if(i > 0) {
			total = total+1
		}
	}
	total
}

tossCoin(100)
tossCoin(2000)
tossCoin()



# Section 3.1
churn = read.csv("churn.csv") # change depending where your data is stored
require(rpart)

test_rows = sample.int(nrow(churn), nrow(churn)/3)
test = churn[test_rows,]
train = churn[-test_rows,]

fit = rpart(churn ~ ., data=train, parms=list(split="gini"))

probs = predict(fit, test)[,2]



# Section 3.3
makePrediction = function(probYes, cutoff) {
	prediction = vector(length=length(probYes))
	for(i in 1:length(prediction)) {
		if(probYes[i] > cutoff) {
			prediction[i] = "Yes"
		} else {
			prediction[i] = "No"
		}
	}
	factor(prediction, levels=c("No", "Yes"))
}



pred = makePrediction(probs, 0.4)
table(pred, test$churn, dnn=c("Predicted", "Actual"))



# Section 3.4
drawROC = function(fit, test) {
	alpha = seq(0, 1, length.out=100)
	
	tp = vector(length=100)
	fp = vector(length=100)
	
	probs = predict(fit, test)
	for(i in 1:100) {
		pred = makePrediction(probs[,2], alpha[i])
		confusion = table(pred, test$churn, dnn=c("Predicted", "Actual"))
		tp[i] = confusion[2,2]/(confusion[1,2]+confusion[2,2])
		fp[i] = confusion[2,1]/(confusion[1,1]+confusion[2,1])
	}
	
	plot(fp, tp, type="l")
}

drawROC(fit, test)




# Extra for the lecture ... how does the ROC change with different train/test sets?
# Run all this at once
plot(-1, xlim=c(0,1), ylim=c(0,1), xlab="fp", ylab="tp")
# Don't close this empty plot!
drawROC = function(fit, test) {
	alpha = seq(0, 1, length.out=100)
	
	tp = vector(length=100)
	fp = vector(length=100)
	
	probs = predict(fit, test)
	for(i in 1:100) {
		pred = makePrediction(probs[,2], alpha[i])
		confusion = table(pred, test$churn, dnn=c("Predicted", "Actual"))
		tp[i] = confusion[2,2]/(confusion[1,2]+confusion[2,2])
		fp[i] = confusion[2,1]/(confusion[1,1]+confusion[2,1])
	}
	
	points(fp, tp, type="l")
}
for(i in 1:100) {
	test_rows = sample.int(nrow(churn), nrow(churn)/3)
	test = churn[test_rows,]
	train = churn[-test_rows,]

	fit = rpart(churn ~ ., data=train, parms=list(split="gini"))

	drawROC(fit, test)
}


