@AbapCatalog.sqlViewName: 'ZC120CDS0003_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[C1] Standard Table'
define view ZC120CDS0003 as select from ztc120001
{
    bukrs,
    belnr,
    gjahr,
    buzei,
    bschl
    
}
