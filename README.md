<p align="center">
   <img alt="Logo" src="https://user-images.githubusercontent.com/1682202/160557212-c23c2bea-4179-4223-abfe-90f4a92e8aaa.png#gh-light-mode-only"/ width="400">
   <img alt="Logo" src="https://user-images.githubusercontent.com/1682202/160557880-ebd4d53f-5ed8-40d2-b20c-7da90443f389.png#gh-dark-mode-only"/ width="400">

   <h4 align="center"> Model Open Data collaboratively using dbt and DuckDB </h4>
</p>

## What is Datadex?

Datadex is a proof of concept project to explore how people could model Open Tabular Datasets using SQL.

### Features

- Data as code. Version your SQL models and datasets.
- Package management. Publish and share your models for other people to build on top of them!
- Fully Open Source. Run everything locally.

## Usage

1. [Download some open datasets locally](Makefile). It'll be possible to query remote datasets from the [`sources` directory](models/sources).
2. Execute `dbt run` to build all the defined models.
3. Pushed changes to GitHub `main` branch, [a GitHub Action will trigger and push the final database as a set of parquet files to IPFS](https://github.com/davidgasquez/datadex/actions/workflows/docs.yml).
4. Query and share the data! E.g: you can use [DuckDB WASM online shell](https://shell.duckdb.org/) to query the models.

This SQL gets the [`taxi_vendors`](models/taxi_vendors.sql) model:

```sql
select
    *
from 'https://bafybeie4xkvoskx2uh6gin636htlufm7wecqagomodg5pcsvweysoryonq.ipfs.dweb.link/4_taxi_vendors.parquet';
```

You can also query the full [`raw_taxi_tripdata`](models/sources/raw_taxi_tripdata.sql) dataset using the following query:

```sql
select
    count(*)
from 'https://bafybeie4xkvoskx2uh6gin636htlufm7wecqagomodg5pcsvweysoryonq.ipfs.dweb.link/2_raw_taxi_tripdata.parquet';
```

And, [explore the final database parquet files on IPFS](https://bafybeie4xkvoskx2uh6gin636htlufm7wecqagomodg5pcsvweysoryonq.ipfs.dweb.link/).

This gives us **versioned data models** that produce **versioned datasets** on IPFS. **All automated, all open source**.

## What Works?

- Since DuckDB is using local CSV/Parquet files. It's possible to query them directly with a view. That gives you something similar to streaming data. Say that something (Airbyte/Singer/Meltano) is writting parquet files locally every hour. You can query then like this: `select * from 'data/*.parquet';`.
    - A similar thing could be done with a GitHub action crawling some data every hour and writting it to parquet files somewhere.
- Once the next version of `duckdb` Python is released, there won't be a need to get the CSV/Parquet files locally. This also mean that it'll be possible for anyone to import similar projects [as Git dbt packages](https://docs.getdbt.com/docs/building-a-dbt-project/package-management#git-packages) and build on top of them. Someone importing this repository could build a new model like this `select * from {{ ref('join') }}`.
- Have I mention a [ready to use DuckDB database is exported with each tag to IPFS](https://bafybeibeqezzvmxyesrub47hsacrnb3h6weghemwhlssegsvzhc7g3lere.ipfs.dweb.link/)? You can recreate the same database in any computer or browser by running `import database https://bafybeibeqezzvmxyesrub47hsacrnb3h6weghemwhlssegsvzhc7g3lere.ipfs.dweb.link`. Useful if you have complex views and want to start playing with them without having to copy paste a lot!
- Every release will push a new version of the database to IPFS, effectively versioning the data. A bit wasteful but might be useful if you want to keep track of all the changes and not break other projects reading from old versions.
- All the other awesome dbt features like `tests` and `docs`. [Docs are automatically generated and published on GitHub Pages](https://davidgasquez.github.io/datadex). E.g: [`yellow_taxi_trips.sql` documentation](https://davidgasquez.github.io/datadex/#!/model/model.datadex.yellow_taxi_trips).
- As the data is on IPFS... it should be possible to mint these datasets as NFT? Not saying is a great idea, but I feel there is something that can be done there to align incentives!
- Oh! And is also possible to run visualizations on the parquet files in VSCode or Codespaces!

![1648245902](https://user-images.githubusercontent.com/1682202/160208641-0cf3e7c5-6339-408c-a08a-b5d164d1ed64.png)

## Future

- Figure out how to best handle and export bigger datasets.
    - Also, if someone is not building on top of a large model, it doens't make sense to instantiate it locally.
- Provide a clean URL for the versioned parquet files. Quering them should be easy. E.g: `select * from user.repo.ipfs.dweb/filename.parquet`.
- Not sure how but would be awesome to have a way to list/explore all the datasets created this way and all their versions.

## Setup

The fastest way to start using Datadex is via [VSCode Remote Containers](https://code.visualstudio.com/docs/remote/containers). Once inside the develpment environment, you can start playing around (e.g: `dbt run`)! The development environment can also run in your browser thanks to GitHub Codespaces.

## Motivation

This small project was created after [thinking how an Open Data Protocol could look like](https://publish.obsidian.md/davidgasquez/Open+Data+Protocol)! I just wanted to stitch together a few open source technologies and see what could they do.

## Acknowledgements

- This proof of concept was created thanks to open source projects like [DuckDB](https://www.duckdb.org/) and [dbt](https://getdbt.com).
- Datadex name was inspired by [Juan Benet awesome `data` projects](https://juan.benet.ai/blog/2014-03-11-discussion-scienceexchange/).