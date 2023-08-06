# Learning Bayesian Statistics Webinar

In this webinar we will perform an analysis on a simple, but deceptively tricky, data set. As we work through the analysis, we will

- Emphasize the importance of domain knowledge
- Learn about the "bet the farm" approach to choosing priors.
- Learn tips and tricks for keeping analyses organized.
- Demonstrate some tools I used (some of which I developed) in Bayesian analyses.

You may follow along on your own machine be following the instructions below. Alternatively, you can run the notebooks using [Google Colab](https://colab.research.google.com). The first cell of each notebook will take about five minutes to run because Stan is being installed, so you may wish to run the first cell before we begin the webinar. You can launch the notebooks from the following links.

- [Part I](https://colab.research.google.com/github/justinbois/learnbayes-livecode/blob/main/catastrophe_1.ipynb)
- [Part II](https://colab.research.google.com/github/justinbois/learnbayes-livecode/blob/main/catastrophe_2.ipynb)
- [Part III](https://colab.research.google.com/github/justinbois/learnbayes-livecode/blob/main/catastrophe_3.ipynb)

Note that if you view the notebooks on the GitHub website, the graphics will not appear. This is because I use Bokeh for the graphics, and this is not supported in the GitHub web viewer (as of August 2023).

## Setting up your own machine

To follow along with this webinar on your own machine, you will need a working installation of [Stan](https://mc-stan.org/) and other tools we will use to process the results from our sampling in Stan. In addition to Stan and staples like Numpy, SciPy, Pandas, Xarray, etc., we will be using the following packages

- `bokeh`: My preferred plotting package.
- `bebi103`: A set of utilities I use in my class on statistical inference.
- `iqplot`: A plotting package to plot data sets with one quantitative variable in Bokeh.
- `arviz`: A package for processing MCMC samples.
- `cmdstanpy`: My preferred interface to Stan.

I have found setting up a conda environment to be the easiest way to ensure a group of people I am working with have the necessary installations. Therefore, if you have not already, I advise installing either [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/download). 

We will use the conda environment I built for my class. You can download the YML file specifying the environment here: [bebi103.yml](https://raw.githubusercontent.com/justinbois/learnbayes-livecode/main/bebi103.yml). Upon downloading YML file, you can create the environment by entering the following on the command line (making sure you are in the directory where the `bebi103.yml` file is).

    conda env create -f bebi103.yml

Then, to activate the environment, you will need to do

    conda activate bebi103

Finally, you will need to make sure Stan is installed. You can do this by running

    python -c "import cmdstanpy; cmdstanpy.install_cmdstan()"

on the command line. Note that you will need to have a C++ toolchain installed on your machine for this to work.

To follow along on your own machine, you can clone this repository by doing 

	git clone https://github.com/justinbois/learnbayes-livecode.git

in the appropriate directory, or you can [download it](https://github.com/justinbois/learnbayes-livecode/archive/refs/heads/main.zip).

## Testing your setup

You can test the setup on your machine by running the [test_setup.ipynb notebook](https://github.com/justinbois/learnbayes-livecode/blob/main/test_setup.ipynb) that is included in this repository. You can also make sure Colab is working by [running the test_setup.ipynb notebook with Colab](https://colab.research.google.com/github/justinbois/learnbayes-livecode/blob/main/test_setup.ipynb).