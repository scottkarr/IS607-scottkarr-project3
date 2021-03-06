---
  title: 'GINI Index for Regional US income'
output:
  html_document:
  css: ./lab.css
highlight: pygments
theme: cerulean
pdf_document: default
---

1.  Example 1: tweets via twitteR
Step 1: Load all the required packages
```{r loadPackages, eval=TRUE}
library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
```

2. Step 2: Lets get some tweets in english containing the words "machine learning"
```{r getTweets, eval=TRUE}
mach_tweets = searchTwitter("machine learning", n=500, lang="en")
```

3. Step 3: Extract the text from the tweets in a vector
```{r getTextFromTweets, eval=TRUE}
mach_text = sapply(mach_tweets, function(x) x$getText())
```

4. Step 4: Construct the lexical Corpus and the Term Document Matrix
```{r constructLexicon, eval=TRUE}
We use the function Corpus to create the corpus, and the function VectorSource to indicate that the text is in the character vector mach_text. In order to create the term-document matrix we apply different transformation such as removing numbers, punctuation symbols, lower case, etc.
# create a corpus
R
mach_corpus = Corpus(VectorSource(mach_text))
# create document term matrix applying some transformations
tdm = TermDocumentMatrix(mach_corpus,
control = list(removePunctuation = TRUE,
stopwords = c("machine", "learning", stopwords("english")),
removeNumbers = TRUE, tolower = TRUE))
```

5. Step 5: Obtain words and their frequencies

```{r getWordCounts, eval=TRUE}
# define tdm as matrix
m = as.matrix(tdm)
# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 
# create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)
```

6. Step 6: Let's plot the wordcloud
```{r renderWordCloud, eval=TRUE}
# plot wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
# save the image in png format
png("MachineLearningCloud.png", width=12, height=8, units="in", res=300)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()
```