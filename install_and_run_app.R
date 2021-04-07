################################################################################
### Improve Reproducibility ("environment.yml") and Automate Django Server Startup
### *** Note: Works Only on Windows! ***
################################################################################

install.packages("remotes", repos = "https://cloud.r-project.org")
remotes::install_github("kwb-r/kwb.python")

## Define dependencies (from "tools/requirements.txt")
pkgs <- list(conda = c("django",
                       "django-crispy-forms",
                       "django-extensions",
                       "django-import-export",
                       "django-pandas",
                       "numpy",
                       "markdown2",
                       "pandas",
                       "plotly",
                       "python-decouple"
                       ),
             py = c("django-formtools")
             )

### Define name of conda environment
env_name <- "qmra"

### Create conda environment and install conda/py packages in one call
kwb.python::conda_py_install(env_name = env_name,
                             pkgs = pkgs)

## Export python dependencies in yml
kwb.python::conda_export(condaenv = env_name, export_dir = "tools")

## Opens default browser on windows and start webserver
kwb.python::run_django(condaenv = env_name,
                       cmd = "runserver",
                       path_manage.py = "tools/manage.py")

