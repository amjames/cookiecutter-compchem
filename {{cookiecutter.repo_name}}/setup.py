"""
{{cookiecutter.project_name}}
{{cookiecutter.description}}
"""
from setuptools import setup
import versioneer

DOCLINES = __doc__.split("\n")

setup(
    name='{{cookiecutter.repo_name}}',
    author='{{cookiecutter.author_name}}',
    description=DOCLINES[0],
    long_description="\n".join(DOCLINES[2:]),
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    license='{{cookiecutter.open_source_license}}',
    packages=['{{cookiecutter.repo_name}}', "{{cookiecutter.repo_name}}.tests"],
    # Optional include package data to ship with your package
    package_data={'{{cookiecutter.repo_name}}': []  # + ["data/*.dat"]
                  },
    # Additional entries you may want simply uncomment the lines you want and fill in the data
    # author_email='me@place.org',      # Author email
    # url='http://www.my_package.com',  # Website
    # install_requires=[],              # Required packages, pulls from pip if needed; do not use for Conda deployment
    # platforms=['Linux',
    #            'Mac OS-X',
    #            'Unix',
    #            'Windows'],            # Valid platforms your code works on, adjust to your flavor
    # zip_safe=False,                   # Compress final package or not
    # python_requires=">=3.5",          # Python version restrictions

)
