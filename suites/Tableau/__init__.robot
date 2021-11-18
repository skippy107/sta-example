*** Settings ***
Documentation	Suite Level Settings for Tableau tests
...
...             This file contains keywords that will be executed before all suites and tests
...             in the current folder

Resource	resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API
Resource    resource/setup.resource   # keyword definitions for Test setup and teardown

Suite Setup	     Test Launch
Suite Teardown	 Close Browser
Test Setup       Load Dashboards
Test Teardown    Unload Dashboards

