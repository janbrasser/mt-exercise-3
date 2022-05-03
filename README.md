# MT Exercise 3: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model).

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps for my repository

Clone this repository in the desired place:

    git clone https://github.com/janbrasser/mt-exercise-3
    cd mt-exercise-3

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Train a model with a training script. The script are numbered by their respective dropout rate times 10, so for example, train_3.sh trains with a dropout of 0.3:

    ./scripts/train_3.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh
	
# Changelog

download_data.sh changed to now download the book "Moby dick" Herman Melville from project Gutenberg. 
This fits the size requirements nicely (9181 lines in preprocessed file, with first 460 dropped later, since they are not part of the book)
Also adjusted file paths and process of splitting the data.

Adjusted the training file according to the new file paths and derived six training scripts with different dropout settings.

Udjusted the generation script by updating file paths and increasing the number of generated words to 200

