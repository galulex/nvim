return {
  "tpope/vim-rails",
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "Rails",
      callback = function()
        vim.opt.tags = "./tmp/tags"
        -- Enable gf for Rails partials
        vim.opt_local.suffixesadd:prepend('.html.slim,.html.erb,.html.haml')
        
        -- Set includeexpr to handle Rails partial naming convention
        vim.opt_local.includeexpr = "rails#includeexpr()"
      end,
    })
    
    -- Enhanced gf support for Rails partials in view files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"eruby", "slim", "haml"},
      callback = function()
        -- Set up file extensions for gf
        vim.opt_local.suffixesadd:prepend('.html.slim,.html.erb,.html.haml')
        
        -- Set path to include common Rails view directories
        vim.opt_local.path:append('app/views/**')
        vim.opt_local.path:append('app/views')
        
        -- Custom function to handle Rails partial resolution
        vim.cmd([[
          function! RailsPartialInclude(fname)
            let fname = a:fname
            " Handle render partial: 'path/to/partial'
            if fname =~ '^/'
              " Absolute path from app/views
              let fname = substitute(fname, '^/', '', '')
            endif
            
            " Split path and filename
            let parts = split(fname, '/')
            if len(parts) > 0
              " Add underscore to filename if it doesn't have one
              let filename = parts[-1]
              if filename !~ '^_'
                let parts[-1] = '_' . filename
              endif
            endif
            
            return join(parts, '/')
          endfunction
        ]])
        
        vim.opt_local.includeexpr = "RailsPartialInclude(v:fname)"
      end,
    })
  end,
}
