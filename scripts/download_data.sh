#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/joyce

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/moby_dick/$corpus.txt)
    ln -snf $absolute_path $data/moby_dick/$corpus.txt
done

# download a different interesting data set!

mkdir -p $data/moby_dick

mkdir -p $data/moby_dick/raw

wget https://www.gutenberg.org/files/2701/2701-0.txt
mv 2701-0.txt $data/moby_dick/raw/moby_dick.txt

# preprocess slightly

cat $data/moby_dick/raw/moby_dick.txt | python $base/scripts/preprocess_raw.py > $data/moby_dick/raw/moby_dick.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/moby_dick/raw/moby_dick.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/moby_dick/raw/moby_dick.preprocessed.txt

# split into train, valid and test

head -n 1186 $data/moby_dick/raw/moby_dick.preprocessed.txt | tail -n 726 > $data/moby_dick/valid.txt
head -n 1912 $data/moby_dick/raw/moby_dick.preprocessed.txt | tail -n 726 > $data/moby_dick/test.txt
tail -n 7268 $data/moby_dick/raw/moby_dick.preprocessed.txt > $data/moby_dick/train.txt
