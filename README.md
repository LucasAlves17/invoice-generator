# Invoice Generator

This is a Rails Api-only project, the Front-end to this project is in [this repository](https://github.com/LucasAlves17/invoice-generator-web).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      2.7.7
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.1.7.1
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      PostgreSQL
    </td>
  </tr>
</table>

## Initial settings to run the project

```bash
# clone the project
git clone git@github.com:LucasAlves17/invoice-generator.git

# enter the cloned directory
cd invoice-generator

# install Ruby on Rails dependencies
bundle install

# modify the database config, in the file `config/database.yml` configure your username and password

# create the development and test databases
rails db:create

# create the tables
rails db:migrate

# run the project
rails s
```

The api is available at `http://localhost:3000`.

## Tests

To run the tests:

```bash
rspec
```

## Gems

In this project the following gems were used:

- [rspec-rails](https://github.com/rspec/rspec-rails), to tests;
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers), to to facilitate testing;
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails), to create fixtures;
- [faker](https://github.com/faker-ruby/faker), to generate fake data;
- [active_model_serializers](https://github.com/rails-api/active_model_serializers), to filter the fields from the models;
- [interactor](https://github.com/collectiveidea/interactor), to extract the business logic from the controllers;
- [letter_opener](https://www.ruby-toolbox.com/projects/letter_opener), to open emails sent in the browser;
- [prawn](https://github.com/prawnpdf/prawn), to create the pdf that is attached to the emails.

### API Endpoints

The following endpoints are available:

### Users

| Endpoints                          | Usage                              | Params             |
| ---------------------------------- | ---------------------------------- | ------------------ |
| `POST /api/users`                  | Create a new user or change token. | **email**:[String] |
| `POST /api/users/login`            | Validate the token.                | **token**:[String] |
| `GET /api/users/comfirm?token=123` | Confirm the user token.            |                    |

### Invoices

The following endpoints need a header parameter `Authorization`, which is available after email confirmation.

| Endpoints               | Usage                                                              | Params                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /api/invoices`     | Get all invoices (you can filter by `number` and `date`).          |                                                                                                                                                |
| `GET /api/invoices/:id` | Get a specific invoice                                             |                                                                                                                                                |
| `POST /api/invoices`    | Add a new invoice.                                                 | **number**: [Integer], **date**: [String], **company**: [String], **charge_for**: [String], **total_in_cents**: [Integer], **emails**: [Array] |
| `PUT /api/invoices/:id` | Update the email list and send a email to then(only the new ones). | **emails**: [Array]                                                                                                                            |

### Using Insomnia to test the API

To validate the endpoints I used a software called [Insomnia](https://insomnia.rest/download), you can use the `Insomnia_2023-01-24.json` from this project to import my configuration.

### Future

This project has some features to improve such as:

- improve the pdf generation, I only put the fields in line on the pdf 🙃;
- some fields validation, like email;
- allow updating emails only the user who created the invoice.
