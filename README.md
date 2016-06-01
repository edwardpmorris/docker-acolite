# docker-acolite

A Docker container for the [ACOLITE](https://odnature.naturalsciences.be/remsem/acolite) atmospheric correction processor for marine and inland waters by Vanhellemont & Ruddick (2014, 2015, 2016) distributed by OD Nature Remote Sensing and Ecosystem Modelling team (REMSEM) at the Royal Belgian Institute of Natural Sciences (RBINS).

> ACOLITE is an atmospheric correction and processor for the Landsat-8 (L8) / Operational Land Imager (OLI) and Sentinel-2A (S2A) / MultiSpectral Imager (MSI) developed at RBINS. It allows simple and fast processing of L8 and S2A images for marine and inland water applications. 

For information about using Acolite check out the [ forum](https://odnature.naturalsciences.be/remsem/acolite-forum/)

# Status

In early development, may change at any moment.

## Command line interaction
```
cd acolite_linux &&
idl84/bin/idl -rt=acolite.sav 
-args image=/path/to/image1,/path/to/image2
settings=acolite_settings_file
```

```
docker build --tag="epmorris/acolite:20160520.1" .
```

```
docker run -it -v /home/edward/Desktop/S2:/home/worker/S2 \
  epmorris/acolite:20160520.1 \
    idl84/bin/idl -rt=acolite.sav -args settings=Input/acolite_settings_defaults.cfg image=${HOME}/S2/S2A_OPER_PRD_MSIL1C_PDMC_20160309T104243_R137_V20160308T112023_20160308T112023.SAFE/GRANULE/S2A_OPER_MSI_L1C_TL_MTI__20160308T193334_A003709_T29SQA_N02.01
```

