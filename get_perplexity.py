import re
import os
import pandas as pd

DIRECTORY = 'training_output'
df_train = pd.DataFrame()
df_val = pd.DataFrame()
df_test= pd.DataFrame()
for filename in os.listdir(DIRECTORY):
    with open(f'{DIRECTORY}/{filename}', 'r', encoding = 'utf-8') as f:
        train_ppls = []
        val_ppls = []
        test_ppls = []
        for line in f:
            if re.search('\| end of epoch', line):
                val_ppls.append(float(re.search('\s\s\s(\d?\d?\d.\d\d)', line)[1]))
            elif re.search('\| End of training', line):
                test_ppls.append(float(re.search('\s\s\s(\d?\d?\d.\d\d)', line)[1]))
            elif re.search('\| epoch ', line):
                train_ppls.append(float(re.search('\s\s\s(\d?\d?\d.\d\d)', line)[1]))
    df_train[filename] = train_ppls
    df_val[filename] = val_ppls
    df_test[filename] = test_ppls

df_train.to_csv('train_perplexities.csv')
df_val.to_csv('val_perplexities.csv')
df_test.to_csv('test_perplexities.csv')