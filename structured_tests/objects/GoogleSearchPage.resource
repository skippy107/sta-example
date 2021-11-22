| *** Setting *** | Value |
| Documentation  | Page Object as Resource File Example for Robot Framework |
| Library        | SeleniumLibrary |

| *** Variable *** | Value |
| ${SEARCH_FIELD} | name=q |
| ${SEARCH_BUTTON} | name=btnG |

| *** Keyword *** |
| Click On Search |
|    | [Documentation] | Click the search button to proceed with the search |
|    | SeleniumLibrary.Click Button | ${SEARCH_BUTTON} |

| Close |
|    | [Documentation] | Close the browser window |
|    | SeleniumLibrary.Close Browser | # or is it Selenium2Library.Close Window? |

| Get Title |
|    | [Documentation] | Get the page title for Google search page |
|    | ${result} = | SeleniumLibrary.Get Title |
|    | [Return] | ${result} |

| Open |
|    | [Arguments] | ${url} |
|    | [Documentation] | Open (or go to) the Google search page |
|    | Run Keyword And Return If | ${BROWSER_OPENED} == ${true} | SeleniumLibrary.Go To | ${url} |
|    | SeleniumLibrary.Open Browser | ${url} | ${BROWSER} | #other optional args |
|    | ${BROWSER_OPENED} = | Set Variable | ${true} |

| Search For |
|    | [Arguments] | ${searchTerm} |
|    | [Documentation] | Perform a search on Google (enter search text, then click search) |
|    | GoogleSearchPage.Type Search Term | ${searchTerm} |
|    | Sleep | 1 seconds | Arbitrary delay for page load and action to take effect correctly in automation |
|    | GoogleSearchPage.Click On Search |
|    | Sleep | 2 seconds | Arbitrary delay for page load and action to take effect correctly in automation |

| Type Search Term |
|    | [Arguments] | ${searchTerm} |
|    | [Documentation] | Enter search term into Google search field. This doesn't click the search button as a follow up. |
|    | SeleniumLibrary.Input Text | ${SEARCH_FIELD} | ${searchTerm} |
