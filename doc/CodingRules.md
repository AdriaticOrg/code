# Rules and Guidelines for AL Code

The rules and guidelines are grouped according to two importance levels: critical errors that must be resolved, and important errors that should be resolved. Errors that are not resolved must include an explanation and justification for the error.

> See [Rules and Guidelines for AL Code](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-overview)

## Range Guidelines

Range Name|Description|Example
----------|-----------|-------
Base Code|Formerly known as W1|1, 2, 3,...49.999
Customer Code|Only for customers or demo|50.000, 50.001,...99.000
App|Adriatic Localization range|13.062.525, 13.062.526,...13.063.524
Feature|VAT Date feature sub range|13.062.525, 13.062.526..13.062.550
Owned Elements|When element is part of file that is owned by same feature and has ID (fields, actions, controls, ...)|1,2,3,...49.999
Owned Elements|When element is part of file that is owned by same feature and has no ID (key, keygroup, code, ...)|
Foreign Elements|When element is not part of file owned by same feature and has ID|13.062.525, 13.062.526..13.062.550
Foreign Elements|When element is not part of file owned by same feature and has no ID|See [Code Mark Guidelines](#code-mark-guidelines)

## Code Mark Guidelines

Foreign code should be marked for easier linking and finding features.

### Block of code
``` PAS
// <adl.6>
... some code ...
// </adl.6>
```
### Single code
``` PAS
... some code ...
... added code ... // <adl.6 />
... some code ...
``` 

# Naming Convention

Adriatic Organization has registered ```_adl``` postfix.

> See [Benefits and Guidelines for using a Prefix or Suffix](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-prefix-suffix)

# Best Practices

We recommend following these best practices when developing extensions in AL to ensure consistency and discoverability on file, object, and method naming, as well as better readability of written code.

1. Place as little code in extended objects as possible. 
2. Omit global variables if possible. 

> See [Best Practices for AL](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-bestpracticesforalcode)

# CheckList Submission

The following is a checklist of all requirements that you must meet before submitting an extension for validation. If you do not meet these mandatory requirements, your extension will fail validation.

> See [Checklist for Submitting Your App](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-checklist-submission)

