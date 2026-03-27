#pragma once

#include <vector>

#include "ecmcStrucppLogicIface.hpp"
#include "generated/machine.hpp"

namespace ecmcStrucppExports {

inline void initProgram_MACHINEExports(strucpp::Program_MACHINE& program, std::vector<ecmcStrucppExportedVar>& out) {
  out.clear();
  out.push_back({
    "plugin.strucpp.machine.counter",
    program.COUNTER.raw_ptr(),
    ECMC_STRUCPP_EXPORT_S16,
    0,
  });
  out.push_back({
    "plugin.strucpp.machine.manual_target",
    program.MANUAL_TARGET.raw_ptr(),
    ECMC_STRUCPP_EXPORT_S16,
    1,
  });
}

}  // namespace ecmcStrucppExports
