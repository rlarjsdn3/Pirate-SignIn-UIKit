//
//  String+Extension.swift
//  PirateSignIn
//
//  Created by 김건우 on 5/27/25.
//

import Foundation

extension String {
    
    /// 정규 표현식을 사용하여 문자열이 유효한 이메일 주소인지 판단합니다.
    ///
    /// 유효한 이메일 주소가 되기 위해서는 다음 조건을 모두 충족해야 합니다:
    /// - 로컬 파트(＠ 이전)는 특수문자로 시작하거나 끝나면 안 됩니다.
    /// - 로컬 파트와 도메인 파트는 반드시 ＠(at 기호)로 구분되어야 합니다.
    /// - 도메인 파트(＠ 이후)는 특수문자로 시작하면 안 됩니다.
    /// - 최상위 도메인(TLD)은 2자 이상, 6자 이하의 영문자로 구성되어야 합니다.
    ///
    /// ## 정규 표현식(Regular Expression)
    /// 문자열은 아래 정규 표현식으로 유효한 이메일 주소인지 판단합니다.
    ///
    /// > Regular Expression: ^(?![._%+-=])[A-Za-z0-9._%+-=]+(?<![._%+-=])@(?![._%+-=])(?:[A-Za-z0-9]+\.)+[A-Za-z]{2,6}$
    ///
    /// * **(?![._%+-=])**: 부정 전방 탐색(Negative Lookahead),
    /// * **[A-Za-z0-9._%+-=]+**:
    /// * **(?<![._%+-=])**: 부정 후방 탐색(Negative Lookbehind),
    /// * **@**: @(at 기호)
    /// * **(?![._%+-=])**: 부정 전방 탐색(Negative Lookahead),
    /// * **(?:[A-Za-z0-9]+\.)+**: 비캡처 그룹(Non-Cature Group),
    /// * **[A-Za-z]{2,6}**:
    ///
    /// > Important: `"john.doe123@sub.example.co.uk"`처럼 도메인에 `.`이 여러 번 포함된 경우, 현재 정규식 패턴으로는 정확하게 일치하지 않을 수 있습니다.
    var checkIsVaildEmailAddress: Bool {
        let pattern = #"^(?![._%+-=])[A-Za-z0-9._%+-=]+(?<![._%+-=])@(?![._%+-=])(?:[A-Za-z0-9]+\.)+[A-Za-z]{2,6}$"#
        return patternWholeMatching(self, pattern: pattern)
    }
    
    /// 정규 표현식을 사용하여 비밀번호가 유효한지 판단합니다.
    ///
    /// 유효한 비밀번호가 되기 위해서는 다음 조건을 모두 충족해야 합니다:
    /// - 길이는 6자 이상, 20자 이하여야 합니다.
    /// - 영문 대문자 또는 소문자를 최소 1자 이상 포함해야 합니다.
    /// - 숫자(0~9)를 최소 1자 이상 포함해야 합니다.
    /// - 특수문자(!@#$%^&*-+=?)를 최소 1자 이상 포함해야 합니다.
    ///
    /// ## 정규 표현식(Regular Expression)
    /// 문자열은 아래 정규 표현식으로 유효한 비밀번호인지 판단합니다.
    ///
    /// > Regular Expression: ^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*-+=?])[A-Za-z0-9!@#$%^&*-+=?]{6,20}$
    ///
    /// * **(?=.*[a-z])**: 긍정 전방 탐색(Positive Lookahead),
    /// * **(?=.*[A-Z])**: 긍정 전방 탐색(Positive Lookahead),
    /// * **(?=.*[!@#$%^&*-+=?])**: 긍정 전방 탐색 (Positive Lookahead),
    /// * **[A-Za-z0-9!@#$%^&*-+=?]{6,20}**:
    ///
    var checkIsValidPassword: Bool {
        let pattern = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*-+=?])[A-Za-z0-9!@#$%^&*-+=?]{6,20}$"#
        return patternWholeMatching(self, pattern: pattern)
    }
    
    /// 주어진 문자열이 정규 표현식 패턴과 전체적으로 일치하는지 여부를 반환합니다.
    ///
    /// - Parameters:
    ///   - string: 검사할 대상 문자열입니다.
    ///   - pattern: 검사에 사용할 정규 표현식 패턴 문자열입니다.
    /// - Returns: 문자열이 패턴과 정확히 일치하면 `true`, 그렇지 않으면 `false`를 반환합니다.
    func patternWholeMatching(
        _ string: String,
        pattern: String
    ) -> Bool {
        guard !self.isEmpty else { return false}
        
        guard
            let pattern = try? NSRegularExpression(pattern: pattern)
        else { return false }
        let nsrange = NSRange(string.startIndex... , in: string)
        guard
            let match = pattern.firstMatch(in: string, range: nsrange)
        else { return false }
        return match.range == nsrange
    }
}
