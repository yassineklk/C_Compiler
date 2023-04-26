#include "../IR/CFG.h"
#include "../IR/IRInstr.h"
#include "../IR/BasicBlock.h"
#include "CodeGen.h"

class Gen_x86 : public CodeGen
{
public:
    Gen_x86(CFG *cfg) : CodeGen(cfg) {}
    virtual ~Gen_x86() {}
    void gen_asm(ostream &o);
    virtual void gen_asm_prologue(ostream &o);
    virtual void gen_asm_epilogue(ostream &o);
};