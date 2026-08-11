# History: 003 - Update Roshana Technical Design Document & Implementation Plan

## User Request
Apply changes to the plan:
- Skip Tajik locale (`tg_TJ`) to prevent mistakes in Tajik Cyrillic script.
- Skip AI assistant feature (remove streaming Q&A AI assistant engine).
- Default to Google Fonts stack for MVP: Implement `Vazirmatn` (Arabic script for Persian `fa_IR` & Dari `fa_AF`) and `Inter` (Latin script for English `en_US`).

## Assistant Response
Updated Technical Design Document (`docs/plans/001_roshana_technical_design_document.md`) and implementation plan artifact to reflect:
1. Streamlined 3-locale system (`fa_IR`, `fa_AF`, `en_US`) with Arabic (RTL) & Latin (LTR) directionality.
2. Google Fonts integration (`Vazirmatn` & `Inter`).
3. Removal of AI streaming assistant subsystem while keeping core reader, audio sync, SRS flashcards, gamification streaks, and RevenueCat monetization.
4. Updated 6-sprint roadmap reflecting the revised MVP scope.
