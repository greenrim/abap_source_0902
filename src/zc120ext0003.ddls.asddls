@AbapCatalog.sqlViewAppendName: 'ZC120EXT0003_V'
@EndUserText.label: '[C1] Fake Standard Table Extend'
extend view ZC120CDS0003 with ZC120EXT0003 
{
   ztc120001.zzsaknr,
   ztc120001.zzkostl,
   ztc120001.zzshkzg,
   ztc120001.zzlgort
}
