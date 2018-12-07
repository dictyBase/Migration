## Genomepage 3.2.0

- Update `helm chart` for `genomepage`
- Update [genecachefn](https://github.com/dictybase-playground/kubeless-nodefn/tree/master/geneids)
  > `$_> kubeless function update \`  
  > `genecachefn --runtime nodejs8 --from-file handler.js --handler handler.file2redis \`  
  > `--dependencies package.json --namespace dictybase`
- Hit the POST route for this function so it will set name-id pairs.
  > `curl -k -X POST https://betafunc.dictybase.local/geneids/cache -H 'Content-Type: application/json' -d @metadata.json`
- Update [genefn](https://github.com/dictybase-playground/kubeless-nodefn/tree/master/gene). Make sure you zip the updated files first. (`zip gene.zip *.js`)
  > `$_> kubeless function update \`  
  > `genefn --runtime nodejs8 --from-file gene.zip --handler handler.gene \`  
  > `--dependencies package.json --namespace dictybase`
- Update [clearfn](https://github.com/dictybase-playground/kubeless-nodefn/tree/master/gene)
  > `$_> kubeless function update \`  
  > `clearfn --runtime nodejs8 --from-file clear.js --handler clear.clearCache \`  
  > `--dependencies package.json --namespace dictybase`
- Run `clearfn`
  > `kubeless function call clearfn -n dictybase`
