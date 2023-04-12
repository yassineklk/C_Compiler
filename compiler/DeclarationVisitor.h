#pragma once

#include <unordered_map>
#include "antlr4-runtime.h"
#include <string>
#include "generated/ifccBaseVisitor.h"
#include "Function.h"

using namespace std;

class DeclarationVisitor : public ifccBaseVisitor
{
public:
	virtual antlrcpp::Any visitAxiom(ifccParser::AxiomContext *ctx) override;
	virtual antlrcpp::Any visitProg(ifccParser::ProgContext *ctx) override;
	virtual antlrcpp::Any visitDeclaration(ifccParser::DeclarationContext *ctx) override;
	virtual antlrcpp::Any visitAssignment(ifccParser::AssignmentContext *ctx) override;
	virtual antlrcpp::Any visitVarexpr(ifccParser::VarexprContext *ctx) override;
	virtual antlrcpp::Any visitFunctiondef(ifccParser::FunctiondefContext *context) override;
	virtual antlrcpp::Any visitFunctiondecl(ifccParser::FunctiondeclContext *context) override;
	virtual antlrcpp::Any visitCallFunction(ifccParser::CallFunctionContext *context) override;

protected:
	unordered_map<string, bool> usedVariables = {};
	unordered_map<string, Function> declaredFunctions = {};
	unordered_map<string, Function> definedFunctions = {};
	vector<Function> calledFunctions = {};
};
